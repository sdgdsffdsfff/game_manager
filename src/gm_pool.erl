-module(gm_pool).

-export([start_link/1, executeDynamic/2, executeStatic/1]).


start_link({Pool, SUser, SPassword, SHost, SPort, SDatabase}) ->
%%	建立数据库连接池
    emysql:add_pool(Pool, 1, SUser, SPassword, SHost, SPort, SDatabase, utf8),
	ok.

%% 对静态表进程操作,
%% 查询操作, 返回查询结果
executeStatic(Value) ->
	Sql = iolist_to_binary(Value),
	Result = emysql:execute(static_pool, Sql),
	case Result of
		{result_packet,_,_,Data,_} ->
			Data
	end.


%%============================================
%%% @doc 共用函数，查询从Stime到Etime之间的数据
%%============================================
executeDynamic( {Stime, Etime}, {Sql, Action, ServerDB} ) ->
	ReSql1 = re:replace(Sql, "#DayStime#", integer_to_list(Stime), [{return, list}]),
	ReSql2 = re:replace(ReSql1, "#DayEtime#", integer_to_list(Etime), [{return, list}]),
	ReSql3 = re:replace(ReSql2, "#DayStime#", integer_to_list(Stime), [{return, list}]),
	ReSql4 = re:replace(ReSql3, "#DayEtime#", integer_to_list(Etime), [{return, list}]),
	case execute(ServerDB, ReSql4) of
		  	ok -> 0; %sql报错
		  	[[undefined]] -> 0;% 计算为空
			[] ->  0;%查询结果为空
		  	SqlRes -> %正常情况
				case Action of
					count -> [[Data]] = SqlRes, Data;
					item ->
						case SqlRes of
							[Data] -> [case I of undefined -> 0; _ -> I end||I<- Data];
							SqlRes -> SqlRes
						end;
					group_by -> SqlRes
				end
	  end;

executeDynamic( {Stime, Etime, TimeUnit}, {Sql, Action, ServerDB} ) ->
	TimeList = gm_fun:time_to_list(Stime, Etime, TimeUnit),
	executeDynamic( TimeList, {Sql, Action, ServerDB} );

executeDynamic( TimeList, {Sql, Action, ServerDB} ) ->
	lists:map( fun( {Stime, Etime} ) -> {Stime, executeDynamic( {Stime, Etime}, {Sql, Action, ServerDB} )} end, TimeList ).


execute( DBName, Value ) ->
	Sql = iolist_to_binary(Value),
	try emysql:execute(DBName, Sql, 10000) of
		{result_packet,_,_,Data,_} ->
			Data;
		{ok_packet,_,_,Data,_,_,_} ->
			Data;
		[{result_packet, _,_,Data,_},_] ->
			Data;
		Error when is_list(Error) ->
			ok;
		_Error ->
			ok
	catch
		_E1:_E2 -> ok
	end.
