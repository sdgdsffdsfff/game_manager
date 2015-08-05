%% @author 余健
%% @doc pub function

-module(gm_fun).
-include( "../include/basic_data.hrl" ).
-include( "../include/table_record.hrl" ).
-export( [all_to_binary/1, all_to_integer/1] ).
-export( [random/2, json/2, time_to_list/3] ).
-export( [read_config/0] ).

-define( AllTOBinary(All), all_to_binary(All) ).

%%============================================
%% @doc 把日期范围转换成从开始时间到结束时间的每一天||每一周||每一月的列表
%%          time_to_daylist( 2014-05-22的时间戳, 2014-05-25的时间戳 ) -> [{2014-05-22 0:00:00的时间戳, 2014-05-22 23:59:59的时间戳}, ......]
%% @spec time_to_daylist( 1400054072, 1400148111 ) -> [{1400054072,1400140472},{1400226872,1400148111}]
%%============================================
time_to_list( Stime, Etime, TimeUnit ) ->
	case TimeUnit of
		day -> time_to_daylist( Stime, Etime );
		week -> time_to_weeklist( Stime, Etime );
		month -> time_to_monthlist( Stime, Etime )
	end.

time_to_daylist( Stime, Etime ) ->
	time_to_list( Stime, Etime+86400, [], 86400 ).

time_to_weeklist( Stime, Etime ) ->
	time_to_list( Stime, Etime+86400*7, [], 86400*7 ).

time_to_list( Stime, Etime, Data, Seconds ) ->
	if
		Stime == Etime ->
			lists:reverse(Data);
		Stime > Etime ->
			lists:reverse([{Stime, Etime}|Data]);
		true ->
			time_to_list( Stime+Seconds, Etime, [{Stime, Stime+Seconds}|Data], Seconds )
	end.

time_to_monthlist( Stime, Etime ) ->
	{{Year,Month,_Day},{0,0,0}} = zt_time:timerToLocalTime( Etime ),
	MaxDay = calendar:last_day_of_the_month(Year, Month),
	time_to_monthlist( Stime, Etime+86400*MaxDay, [] ).

time_to_monthlist( Stime, Etime, Data ) ->
	{{Year,Month,_Day},{0,0,0}} = zt_time:timerToLocalTime( Stime ),
	MaxDay = calendar:last_day_of_the_month(Year, Month),
	if
		Stime == Etime ->
			lists:reverse(Data);
		Stime > Etime ->
			lists:reverse([{Stime, Etime}|Data]);
		true ->
			time_to_monthlist( Stime+86400*MaxDay, Etime, [{Stime, Stime+86400*MaxDay}|Data] )
	end.

all_to_binary( All ) when is_integer( All ) -> integer_to_binary( All );
all_to_binary( All ) when is_list( All ) -> list_to_binary( All );
all_to_binary( All ) when is_float( All ) -> float_to_binary( All );
all_to_binary( All ) when is_binary( All ) -> All;
all_to_binary( All ) -> term_to_binary( All ).

all_to_integer( All ) when is_integer( All ) -> All;
all_to_integer( All ) when is_list( All ) -> list_to_integer( All );
all_to_integer( All ) when is_binary( All ) -> binary_to_integer(All);
all_to_integer( All ) -> All.

random(Min, Max) ->
	case get(random_seed) of
		undefined ->
			random:seed(now());
		_Tuple ->
			ok
	end,
	random:uniform(Max - Min + 1) + Min - 1.

read_config() ->
	FileNameSplit = filename:split( code:which( ?MODULE ) ),
	FilePath = string:join( lists:sublist( FileNameSplit, length( FileNameSplit )-1 ), "/" )++"/game.config",
	case file:consult( FilePath ) of
		{error, _Other} -> 
			{error, "{\"state\":\"102\", \"msg\":\"read game.config error\"}"};
		{ok, Data} ->
			{ok, Data}
	end.

json( KeyList, ValueList ) when is_integer(hd( ValueList ))->
	TupleList = lists:zip( KeyList, ValueList ),
	[{obj, [{Key, ?AllTOBinary(Value)}||{Key, Value}<- TupleList]}];
	
json( KeyList, ValueList ) ->
	Fun = fun( Value ) ->
				TupleList = lists:zip( KeyList, Value ),
				{obj, [{Key, ?AllTOBinary(Value1)}||{Key, Value1}<- TupleList]}
		  	end,
	lists:map( Fun, ValueList ).