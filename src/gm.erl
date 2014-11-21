
-module( gm ).

-include( "../include/gm.hrl" ).

-export([start/0, load/0, get_path/1, init/0]).

init() ->
	c:cd(get_path( "../ebin" )),
	mnesia:stop(),
	mnesia:delete_schema([node()]),
	mnesia:create_schema([node()]),
	mnesia:start(),
	mnesia:create_table( user,  [{disc_copies, [node()]}, {attributes, record_info(fields, user)}] ),
	mnesia:dirty_write(user, {user, "123", "123", {101,102,103,104}, 0}).

%%初始化函数
start() ->
	c:cd(get_path( "../ebin" )),
	mnesia:start(),
	emysql:start(),
	case gm_fun:read_config() of
		{error, _Other} -> ?trace( ["read game.config error"] );
		{ok, [[ServerList, GameMsg, _PlatMsg]]} ->
			DBList = lists:keydelete("all", 1, GameMsg)++[ServerList],
			lists:map( 
			  	fun({Pool,_Descript,DB, UserName, Pwd, IP, Port}) -> 
						gm_pool:start_link({Pool, UserName, Pwd, IP, Port, DB}) 
				end, 
				DBList )
	end.

%%加载代码
load() ->
    Path = get_path("../ebin/" ),
    { ok, List } = file:list_dir( Path ),
    List_fit = [ I||I <- List, lists:suffix( ".beam", I ) ],
    [ load( I )||I <- List_fit ].

load( StringTemp ) ->
    case string:tokens( StringTemp, "." ) of
        [ Temp, _ ] ->
            c:l( list_to_atom( Temp ) );
        _Other ->
            []
    end.

get_path( Str )->
    Root = filename:split( code:which( ?MODULE ) ),
    join( Root, Str ).  
join( List, "../"++Str )-> join( lists:sublist( List, length( List )-1 ), Str );
join( List, Str )-> string:join( lists:sublist( List, length( List )-1 )++[Str], "/" )--"/".