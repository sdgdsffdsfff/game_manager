-record( user, {userName, pwd, platformId} ).

-define( trace(List), error_logger:error_msg( "~p...~p...log:~p~n", [ ?MODULE, ?LINE, List ] ) ).

-define( ServerLIST, "xw_user" ).
