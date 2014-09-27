%% @author 余健
%% @doc 玩家数据统计

-module(gm_data1).

-include( "../include/gm.hrl" ).
-export([handle/1]).

handle( {"0", ServerDB, PaltformId, StimeStr, EtimeStr} ) ->
	SqlData = reg_data( ServerDB, PaltformId, gm_fun:all_to_integer(StimeStr), gm_fun:all_to_integer(EtimeStr) ),
	{ok, gm_fun:json( ["dayTime", "add", "online"], SqlData )};

handle( {"1", ServerDB, PaltformId, StimeStr, EtimeStr} ) ->
	SqlData = retention_select( ServerDB, PaltformId, gm_fun:all_to_integer(StimeStr), gm_fun:all_to_integer(EtimeStr) ),
	{ok, gm_fun:json( ["dayTime", "reg", "renum_1", "re_1", "renum_2", "re_2","renum_3", "re_3","renum_4", "re_4", 
					   		   "renum_5", "re_5","renum_6", "re_6","renum_7", "re_7","renum_8", "re_8","renum_9", "re_9"], SqlData )};
	
handle( _Other ) ->
	?trace( ["no this handle", _Other] ).


%%1.reg 表增加onlineTime字段，玩家登录更新该字段，如果是今天第一次登录，account_amount+1
%%2.新增表账户活跃表（account_amount），记录每天不重复的账户登录数量
reg_data( ServerDB, PaltformId, Stime, Etime ) ->
	TimeList = gm_fun:time_to_list(Stime, Etime, day),
	case {ServerDB, PaltformId} of
		{"all", "all"} ->
			Sql1 =  "SELECT COUNT(*) FROM `"++?ServerLIST++"`.`user` WHERE regTime >= #DayStime# AND regTime < #DayEtime#;",
			%Sql2 = "SELECT amount FROM `"++?ServerLIST++"`.`account_amount` WHERE `date` = #DayStime#;",
			Reg = gm_pool:executeDynamic(TimeList, {Sql1, count, "server_list"}),
			%Amount = gm_pool:executeDynamic({Stime, Etime, day}, {Sql2, count, ServerDB});
			Amount = [{_M, "暂无数据"}||{_M, _N} <- TimeList],
			[[Time, RegNum, OnlineNum]||{{Time, RegNum}, {Time, OnlineNum}}<-lists:zip( Reg, Amount )];
		{"all", PaltformId} ->			
			Sql1 =  "SELECT COUNT(*) FROM `"++?ServerLIST++"`.`user` WHERE regTime >= #DayStime# AND regTime < #DayEtime# AND platformId = "++PaltformId++";",
			Reg = gm_pool:executeDynamic(TimeList, {Sql1, count, "server_list"}),
			Amount = [{_M, "暂无数据"}||{_M, _N} <- TimeList],
			[[Time, RegNum, OnlineNum]||{{Time, RegNum}, {Time, OnlineNum}}<-lists:zip( Reg, Amount )];
		
		{ServerDB, "all"} ->
			Sql1 = "SELECT COUNT(*) FROM attr WHERE createTime>=#DayStime# AND createTime < #DayEtime# AND uid >= 163",
			Sql2 = "SELECT COUNT(DISTINCT uid) FROM day_online_time WHERE `date`>=#DayStime# AND `date`<#DayEtime#",
			Reg = gm_pool:executeDynamic(TimeList, {Sql1, count, ServerDB}),
			Online = gm_pool:executeDynamic(TimeList, {Sql2, count, ServerDB}),
			[[Time, RegNum, OnlineNum]||{{Time, RegNum}, {Time, OnlineNum}}<-lists:zip( Reg, Online )];
		
		{ServerDB, PaltformId} ->
			Sql1 = "SELECT COUNT(*) FROM attr WHERE createTime>=#DayStime# AND createTime < #DayEtime# AND uid >= 163 AND platformId = "++PaltformId++";",
			Sql2 = "SELECT COUNT(DISTINCT uid) FROM day_online_time WHERE `date`>=#DayStime# AND `date`<#DayEtime# AND platformId = "++PaltformId++";",
			Reg = gm_pool:executeDynamic(TimeList, {Sql1, count, ServerDB}),
			Online = gm_pool:executeDynamic(TimeList, {Sql2, count, ServerDB}),
			[[Time, RegNum, OnlineNum]||{{Time, RegNum}, {Time, OnlineNum}}<-lists:zip( Reg, Online )]
	end.
	

retention_select( ServerDB, PaltformId, Stime, Etime ) ->
	TimeList = gm_fun:time_to_list(Stime, Etime, day),
	RetentionTime = [86400, 2*86400,3*86400,4*86400,5*86400,6*86400,7*86400,14*86400,30*86400],
	Fun = 
		fun( {DayStime, DayEtime} ) ->
			  Sql1 = case PaltformId of
						 	"all" -> "SELECT COUNT(*) FROM attr WHERE createTime>=#DayStime# AND createTime<#DayEtime#;";
						 	PaltformId -> "SELECT COUNT(*) FROM attr WHERE createTime>=#DayStime# AND createTime<#DayEtime# AND platformId = "++PaltformId++";"
					 	end,
			  Reg = gm_pool:executeDynamic({DayStime, DayEtime}, {Sql1, count, ServerDB}),
			  Fun2 = 
				  fun( Retention ) ->
					 Sql2 = 
						 case PaltformId of
						 	"all" -> 
		  						"SELECT COUNT(*) FROM attr AS a, day_online_time AS b WHERE a.createTime>="++integer_to_list(DayStime)++
								" AND a.createTime <"++integer_to_list(DayEtime)++" AND a.uid = b.uid AND b.date ="++integer_to_list(DayStime+Retention)++";";
						 	PaltformId ->
							 	"SELECT COUNT(*) FROM attr AS a, day_online_time AS b WHERE a.platformId = "++PaltformId++" AND a.createTime>="++integer_to_list(DayStime)++
								" AND a.createTime <"++integer_to_list(DayEtime)++" AND a.uid = b.uid AND b.date ="++integer_to_list(DayStime+Retention)++";"
						end,
					gm_pool:executeDynamic({DayStime, DayEtime}, {Sql2, count, ServerDB})
			 	 end,
			  RetentionNum = lists:map( Fun2, RetentionTime ),
			  [DayStime, Reg|lists:append([case {I, Reg} of {0,_} -> [0,0]; {_,0} -> [0,0]; {I, Reg} -> [I, I/Reg] end || I<- RetentionNum])]
			  
		end,
	lists:map( Fun, TimeList ).


