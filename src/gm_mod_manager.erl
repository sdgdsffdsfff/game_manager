%% @author 余健
%% @doc 获取数据

-module(gm_mod_manager).
-export( [attr/1, mate/1,time/1] ).

attr( Uid ) ->
	[[Name]] = gm_db_pool:executeDynamic([<<"SELECT `name` FROM `attr` WHERE uid = ">>,integer_to_binary( Uid ),<<";">>]),
	Name.

mate( MateId ) ->
	[[Name]] = gm_db_pool:executeDynamic([<<"SELECT `name` FROM `attr` WHERE uid = ">>,integer_to_binary( abs(MateId) ),<<";">>]),
	Name.

time( [Time, Action] ) ->
	case Time /= 0 of
		true -> 
			case Action of
				1 -> "封号";
				2 -> "禁言";
				3 -> timerToLocalTime( Time )
			end;
		false -> "无"
	end.


timerToLocalTime(Timer) ->
	MegaSecs = trunc(Timer / 1000000),
	Secs = Timer rem 1000000,
	{{Y,M,D},{H,Mi,S}} = calendar:now_to_local_time({MegaSecs, Secs, 0}),
	integer_to_list(Y)++"-"++integer_to_list(M)++"-"++integer_to_list(D)++" "++integer_to_list(H)++":"++integer_to_list(Mi)++":"++integer_to_list(S).