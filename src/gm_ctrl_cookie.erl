%% @author 余健
%% @doc 验证session 

-module(gm_ctrl_cookie).

-export( [login/1, logout/2, check_cookie/2] ).
-include("yaws_api.hrl").

check_cookie( A, Key ) ->
    H = A#arg.headers,
    case yaws_api:find_cookie_val( Key, H#headers.cookie ) of
        Val when Val /= [] ->
            case yaws_api:cookieval_to_opaque( Val ) of
                {ok, Sess} ->
                    {ok, Sess, Val};
                {error, { has_session, Sess}} ->
                    {ok, Sess, Val};
                Else ->
                    {error, Else}
            end;
        [] ->
            {error, nocookie}
    end.

login( A ) -> 
    case check_cookie( A, "gmadmin" ) of
        { ok, User, _ } ->
            {ok, User};
        _ ->
            {error, "nocookies"}
    end.

logout(A, Key) ->
    case check_cookie( A, Key ) of
        {ok, _Sess, Cookie} ->
            {ok, Cookie};
        _       ->
            {error, "no this cookies"}
    end.
