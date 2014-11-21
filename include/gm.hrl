-record( user, {userName, pwd, platformId, state} ).
	%state=0查询所有渠道，state=1标识有一个渠道，state=2标识有多个渠道

-define( trace(List), error_logger:error_msg( "~p...~p...log:~p~n", [ ?MODULE, ?LINE, List ] ) ).

-define( ServerLIST, "xw_user" ).
