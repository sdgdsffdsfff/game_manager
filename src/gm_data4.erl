%% @author 余健
%% @doc 数据查询 -》 游戏数据

-module(gm_data4).
-include( "../include/gm.hrl" ).
-export([handle/1]).


handle( {"0", ServerDB, PlatformId, []} ) ->
	SqlData = currency( ServerDB, PlatformId ),
	{ok, gm_fun:json( ["currency_1", "currency_2", "currency_3", "currency_4"], SqlData )};


handle( {"1", ServerDB, PlatformId, [{"option", Economy_option}, {"stime", StimeStr}, {"etime", EtimeStr}]} ) ->
	Stime = gm_fun:all_to_integer(StimeStr),
	Etime = gm_fun:all_to_integer(EtimeStr),
	SqlData = economy( ServerDB, PlatformId, Economy_option, Stime, Etime ),
	{ok, gm_fun:json( ["id", "num"], SqlData )};

handle( {"2", ServerDB, PlatformId, [{"prop_option", PropOption}]} ) ->
	SqlData = propOption( ServerDB, PlatformId, PropOption ),
	{ok, gm_fun:json( ["id", "num"], SqlData )};

handle( _Other ) ->
	?trace( ["no this handle", _Other] ).

currency( ServerDB, PlatformId ) ->
	Sql = case PlatformId of
		"all" ->
			"SELECT SUM( rmb ), SUM( learn ), SUM( gold ), SUM( drug ) FROM attr WHERE uid>= 163;";
		PlatformName ->
			"SELECT SUM( rmb ), SUM( learn ), SUM( gold ), SUM( drug ) FROM attr WHERE uid>= 163 AND platformId = "++PlatformName++";"
	end,
	gm_pool:executeDynamic( {0, 0}, {Sql, item, ServerDB} ).

economy( ServerDB, _PlatformId, Economy_option, Stime, Etime ) ->
	Sql = case Economy_option of
				"0" -> "SELECT costId, SUM(num) FROM gold_cost WHERE `time` >=#DayStime# AND `time`<#DayEtime# GROUP BY costId";
				"1" -> "SELECT costId, SUM(num) FROM rmb_cost WHERE `time` >=#DayStime# AND `time`<#DayEtime# GROUP BY costId";
				"2" -> "SELECT costId, SUM(num) FROM learn_cost WHERE `time` >=#DayStime# AND `time`<#DayEtime# GROUP BY costId"
			end,
	gm_pool:executeDynamic( {Stime, Etime+86400}, {Sql, item, ServerDB} ).

propOption( ServerDB, _PlatformId, PropOption ) ->
	Sql =case PropOption of
		"0" -> "SELECT tableId, count(num) FROM item GROUP BY tableId";
		"1" -> "SELECT tableId, count(uid) FROM skill GROUP BY tableId";
		"2" -> "SELECT mateId, count(mateId) FROM mate_attr GROUP BY mateId"
	end,
	gm_pool:executeDynamic( {0, 0}, {Sql, item, ServerDB} ).