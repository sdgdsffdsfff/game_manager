-module(gm_db_pool).

-export([start_link/2, executeDynamic/1, executeStatic/1]).

-define(EXECUTE_DYNAMIC_SQL, execute_dynamic_sql).

start_link({SSize, SUser, SPassword, SHost, SPort, SDatabase}, {DSize, DUser, DPassword, DHost, DPort, DDatabase}) ->
	emysql:start(),
%%	建立静态表连接池
    emysql:add_pool(static_pool, SSize, SUser, SPassword, SHost, SPort, SDatabase, utf8),
%%  建立动态表连接池
    emysql:add_pool(dynamic_pool, DSize, DUser, DPassword, DHost, DPort, DDatabase, utf8),
	ok.

%% 对动态表进程操作,
%% 插入操作, 返回Id
%% 查询操作, 返回查询结果
executeDynamic(Value) ->
	Sql = iolist_to_binary(Value),
	if (Sql =:= <<>>) or (Sql =:= <<"">>) ->
		   [];
	   true ->
			executeDynamic(Sql, 0)
	end.

% 5次执行失败,将其存到这个文件里
executeDynamic(Sql, 5) ->
	mnesiaDBA_pub_function:log(Sql, "../doc/sql_log.txt");

executeDynamic(Sql, Num) ->
	try
		Result = emysql:execute(dynamic_pool, Sql),
		case Result of
			{result_packet,_,_,Data,_} -> Data;
			{ok_packet,_,_,Data,_,_,_} -> Data;
			[{ok_packet,_,_,Data,_,_,_} | _]-> Data;
			[{result_packet, _,_,Data,_},_] -> Data;
			Error when is_list(Error) -> io:format( "db error :~p ~n~p~n", [ Sql, Error ] );
			Error -> io:format( "db error :~p ~n~p~n", [ Sql, Error ] )
		end
	catch
		E1:E2 ->
			io:format( "sql error :~p ~n~p~n", [ E1, E2 ] ),
			%如果执行失败,暂停10秒,继续执行
			timer:sleep(10000),
			executeDynamic(Sql, Num+1)
	end.
					
%% 对静态表进程操作,
%% 查询操作, 返回查询结果
executeStatic(Value) ->
	Sql = iolist_to_binary(Value),
	Result = emysql:execute(static_pool, Sql),
	case Result of
		{result_packet,_,_,Data,_} ->
			Data
	end.
				