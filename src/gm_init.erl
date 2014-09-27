%% @author 余健
%% @doc 初始化函数

-module(gm_init).

-export([start/0, load/0]).

%%初始化函数
start() ->
	emysql:start(),
	gm_db_pool:start_link({1, "root", "123", "192.168.0.200", 3306, "xw_static_140"},{16, "root", "123", "192.168.0.200", 3306, "yujian_dynamic_140"}).

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