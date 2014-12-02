%% @author 余健
%% @doc 收入统计

-module(gm_data2).

-include( "../include/gm.hrl" ).
-export([handle/1]).

handle( {"0", ServerDB, PaltformId, [{"stime", StimeStr}, {"etime", EtimeStr}]} ) ->
	SqlData = pay_data( ServerDB, PaltformId, gm_fun:all_to_integer(StimeStr), gm_fun:all_to_integer(EtimeStr) ),
	{ok, gm_fun:json( ["dayTime", "all", "allnum", "allrole", "reg", "regnum", "regrole"], SqlData )};

handle( _Other ) ->
	?trace( ["no this handle", _Other] ).

pay_data( _ServerDB, PaltformId, Stime, Etime ) ->
	TimeList = gm_fun:time_to_list(Stime, Etime, day),
	Sql1 = 
		case PaltformId of
			"all" ->
				"SELECT SUM(orderMoney), COUNT(*), COUNT(DISTINCT uid) FROM `"++?ServerLIST++"`.rmb_info WHERE `time`>=#DayStime# AND `time` <#DayEtime#;";
			PaltformId ->
				"SELECT SUM(orderMoney), COUNT(*), COUNT(DISTINCT uid) FROM `"++?ServerLIST++"`.rmb_info WHERE  platformId = "++PaltformId++" AND `time`>=#DayStime# AND `time` <#DayEtime#;"
		end,
	AllList = gm_pool:executeDynamic(TimeList, {Sql1, item, "server_list"}),
	Sql2 = 
		case PaltformId of
			"all" -> "SELECT SUM(b.orderMoney), COUNT(*), COUNT(DISTINCT b.uid) FROM `user` AS a, rmb_info AS b WHERE a.createTime >=#DayStime# AND a.createTime < #DayEtime# AND a.uid = b.uid AND b.`time`>=#DayStime# AND b.`time` <#DayEtime#;";
			PaltformId -> "SELECT SUM(b.orderMoney), COUNT(*), COUNT(DISTINCT b.uid) FROM `user` AS a, rmb_info AS b WHERE a.createTime >=#DayStime# AND a.createTime < #DayEtime# AND a.uid = b.uid AND b.`time`>=#DayStime# AND b.`time` <#DayEtime#;"
		end,
	RegList = gm_pool:executeDynamic(TimeList, {Sql2, item, "server_list"}),
	Fun = fun({{Stime1, 0}, {Stime1, 0}}) ->[Stime1, 0,0,0,0,0,0];
			      ({{Stime1, 0}, {Stime1, [Reg, RegNum, RegRole]}}) -> [Stime1, 0,0,0,Reg, RegNum, RegRole];
				  ({{Stime1, [All, AllNum, AllRole]}, {Stime1, 0}}) -> [Stime1, All, AllNum, AllRole, 0, 0, 0];
			 	  ({{Stime1, [All, AllNum, AllRole]}, {Stime1, [Reg, RegNum, RegRole]}}) -> [Stime1, All, AllNum, AllRole, Reg, RegNum, RegRole]
		  	end,
	lists:map(Fun, lists:zip(AllList, RegList)).