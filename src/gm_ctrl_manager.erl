%% @author 余健
%% @doc 产生数据发回给页面
%% state 状态码： 401服务器代码出现问题 1001查询为空

-module(gm_ctrl_manager).
-include( "table_record.hrl" ).
-export([api/2, manager/2]).

api( Action, Args ) -> 
	manager( Action, Args ).
%% 	try manager( Action, Args ) of
%% 		Json -> Json
%% 	catch
%% 		_:_Why -> "{\"state\":\"401\"}" 
%% 	end.

manager( "gm_1_1", {UserName, Uid} ) ->
	UidList = case UserName of
			"" ->[[Uid]];
			_ ->
				gm_db_pool:executeDynamic([<<"SELECT uid FROM `attr` WHERE `name` LIKE '%">>,list_to_binary(UserName),<<"%' AND uid > 162;">>])
		end,
	NewUidLists = case length(UidList) > 8 of
			true ->
				lists:sublist(UidList, 8);
			false ->
				UidList
		end,
	case NewUidLists of
		[] -> "{\"state\":\"1001\"}" ;
		NewUidLists ->
			UidDatas = lists:foldl(fun([Uid], Roles) ->[attr(Uid)|Roles] end, [], NewUidLists),
			rfc4627:encode({obj, [{"uids", integer_to_binary(length( NewUidLists ))}, {"res", UidDatas}]})
	end.

-define( BUIDING, [{1, "building1"}, {2, "building2"}, {3, "building3"}, {4, "building4"}, {5, "building5"}, {6, "building6"}] ).
attr(Uid) ->
	[AttrRecord] = gm_db_pool:executeDynamic([<<"SELECT * FROM attr WHERE uid = ">>,list_to_binary( Uid ),<<";">>]),
	[[_, _, Acu1,_,_,Acu2,_,Acu3,_,Acu4]] = gm_db_pool:executeDynamic([<<"SELECT * FROM acu WHERE uid = ">>,list_to_binary( Uid ),<<";">>]),
	BuidingRecord = gm_db_pool:executeDynamic([<<"SELECT * FROM building WHERE uid = ">>,list_to_binary( Uid ),<<";">>]),
	[[VipLv]] = gm_db_pool:executeDynamic([<<"SELECT vipLv FROM vip WHERE uid = ">>,list_to_binary( Uid ),<<";">>]),
	OrderMoney = 
		case gm_db_pool:executeDynamic([<<"SELECT sum(orderMoney) FROM recharger_record WHERE uid = ">>,list_to_binary( Uid ),<<";">>]) of
			[[undefined]] -> 0;
			[[AllMoney]] -> AllMoney
		end,

	[[_,_,_,S1,S2,S3,S4,S5,S6,S7,S8,S9]] = gm_db_pool:executeDynamic([<<"SELECT * FROM lineup WHERE uid = ">>,list_to_binary( Uid ),<<";">>]),
	TeamSeat = case [S||S<- [S1,S2,S3,S4,S5,S6,S7,S8,S9], S < 0] of
			[Seat1] -> [{team1, mate, Seat1}];
			[Seat1, Seat2] -> [{team1, mate, Seat1}, {team2, mate, Seat2}];
			[Seat1, Seat2, Seat3] -> [{team1, mate, Seat1}, {team2, mate, Seat2}, {team3, mate, Seat3}]
		end,
	KeyValues2 = gm_pub_function:record_data(line_up, TeamSeat, []),
	Seat4_1 = 
		case [S||S<- [S1,S2,S3,S4,S5,S6,S7,S8,S9], S > 0, S /= list_to_integer(Uid)] of
			[] -> {team4, []};
			[Seat4] -> {team4, gm_mod_manager:attr(Seat4)}
		end,
	
	KeyValues1 = gm_pub_function:record_data(attr, [{uid, #attr.uid}, {name, #attr.name},{rank, #attr.rank}, {lv,#attr.lv},{strength,#attr.strength},
							{camp, #attr.camp, basic},{teamRank, #attr.teamRank}, {teamNum, #attr.teamNum}, {teamStrength, #attr.teamStrength},{gangId, #attr.gangId, basic},
							{closure, #attr.closure, time, 1}, {gagTime, #attr.gagTime, time, 2}, {sweepPoint, #attr.sweepPoint},{gold, #attr.gold},{rmb, #attr.rmb},
							{learn, #attr.learn},{vit, #attr.vit},{exp, #attr.exp},{practice, #attr.practice},{drug, #attr.drug},
							{downlineTime, #attr.downlineTime, time, 3},{createTime, #attr.createTime, time,3},{onlineTime, #attr.onlineTime, time,3}], AttrRecord),
	
	KeyValues3 = [{acu1, Acu4}, {acu2, Acu2}, {acu3, Acu3}, {acu4, Acu1}],
	FunBuilding = fun( [_, _, Type, Lv], Data ) ->
						  case lists:keyfind(Type, 1, ?BUIDING) of
							  false -> Data;
							  {Type, Build} -> [{Build, Lv}|Data]
						  end
				  		end,
	KeyValues4 = lists:foldl( FunBuilding, [],  BuidingRecord ),
	Res = KeyValues1++KeyValues2++KeyValues3++KeyValues4++[{viplv, VipLv}, {rechage, OrderMoney}, Seat4_1],
	{obj, [{JsonKey, all_to_binary(JsonValue)}||{JsonKey, JsonValue}<-Res]}.

all_to_binary( All ) when is_integer( All ) -> integer_to_binary( All );
all_to_binary( All ) when is_list( All ) -> list_to_binary( All );
all_to_binary( All ) when is_binary( All ) -> All;
all_to_binary( All ) -> term_to_binary( All ).