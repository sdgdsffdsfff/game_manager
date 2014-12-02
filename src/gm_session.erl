%% @author 余健
%% @doc 验证session 

-module(gm_session).

-include("../include/yaws_api.hrl").
-include( "../include/gm.hrl" ).

-export( [login/1, logout/1, isSession/1] ).

login( {A, UserName, Pwd} ) -> 
    case check_cookie( {A, "gmadmin"} ) of
        { ok, _User, _ } -> {ok, "ok"};
        _ ->
			case mnesia:dirty_read(user, UserName ) of
				[] -> {json, "{\"state\":\"104\"}"};
				[UserVO] -> 
					if
						UserVO#user.pwd  == Pwd -> {ok, "ok"};
						true -> {json, "{\"state\":\"104\"}"}
					end
			end
    end.

logout({A, Key}) ->
    case check_cookie( {A, Key} ) of
        {ok, _Sess, Cookie} ->
			yaws_api:delete_cookie_session( Cookie ),
			{ok, "ok"};
        _ -> {ok, "ok"}
    end.

isSession( A ) ->
	case check_cookie( {A, "gmadmin"} ) of
        { ok, Session, _ } -> {"erlang term", Session};
        _ -> {json, "{\"state\":\"105\"}"}
    end.

check_cookie( {A, Key} ) ->
    H = A#arg.headers,
    case yaws_api:find_cookie_val( Key, H#headers.cookie ) of
        CookieVal when CookieVal /= [] ->
            case yaws_api:cookieval_to_opaque( CookieVal ) of
                {ok, Session} ->
                    {ok, Session, CookieVal};
                {error, { has_session, Session}} ->
                    {ok, Session, CookieVal};
                Else ->
                    {error, Else}
            end;
        [] ->
            {error, "nocookie"}
    end.
