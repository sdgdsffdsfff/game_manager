%% @author 余健
%% @doc 玩法分析

-module(gm_data3).

-include( "../include/gm.hrl" ).
-export([handle/1]).

handle( {"0", ServerDB, PaltformId, []} ) ->
	SqlData = lv( ServerDB, PaltformId ),
	{ok, gm_fun:json( ["lv", "num"], SqlData )};

handle( {"1", ServerDB, PaltformId, []} ) ->
	SqlData = camp( ServerDB, PaltformId ),
	{ok, gm_fun:json( ["camp", "num"], SqlData )};
	
handle( _Other ) ->
	?trace( ["no this handle", _Other] ).

lv( ServerDB, PaltformId ) ->
	Sql = case PaltformId of
			"all" ->
				"SELECT lv, COUNT(*) FROM attr WHERE uid > 162 GROUP BY lv;";
			PaltformId ->
				"SELECT lv, COUNT(*) FROM attr WHERE uid > 162 AND platformId = "++PaltformId++" GROUP BY lv;"
		end,
	case gm_pool:executeDynamic( {0, 0}, {Sql, item, ServerDB} ) of
		0 -> [0,0];
		Res -> Res
  	end.

camp(ServerDB, PaltformId) ->
	Sql = case PaltformId of
			"all" ->
				"SELECT camp, COUNT(*) FROM attr WHERE uid > 162 GROUP BY camp";
			PaltformId ->
				"SELECT camp, COUNT(*)  FROM attr WHERE uid > 162 AND platformId = "++PaltformId++" GROUP BY camp;"
		end,
	gm_pool:executeDynamic( {0, 0}, {Sql, item, ServerDB} ).

%% task( ServerDB, PaltformId ) ->
%% 	Sql = case PaltformId of
%% 			"all" ->
%% 				"SELECT lv, COUNT(*) FROM attr WHERE uid > 162 GROUP BY lv;";
%% 			PaltformId ->
%% 				"SELECT lv, COUNT(*) FROM attr WHERE uid > 162 AND platformId = "++PaltformId++" GROUP BY lv;"
%% 		end,
%% 	gm_pool:executeDynamic( {0, 0}, {Sql, item, ServerDB} ).