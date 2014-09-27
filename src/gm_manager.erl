%% @author 余健
%% @doc 产生数据发回给页面

-module(gm_manager).

-include( "../include/gm.hrl" ).

-export([api/2]).

-define( DispatchEvent, 
	[{"login", gm_session, login}, {"login_out", gm_session, logout}, {"check_session", gm_session, isSession},
	 {"data_1", gm_data1}, {"data_2", gm_data2},{"data_4", gm_data4}] ).

api( Event, Args ) ->
	case lists:keyfind( Event, 1, ?DispatchEvent ) of
		{Event, Module, Fun} ->
			try Module:Fun( Args ) of
				{ok, Json} -> "{\"state\":\"200\", \"msg\":\""++Json++"\"}";
				{error, Reason} -> "{\"state\":\"103\", \"msg\":\""++Reason++"\"}";
				{json, Json} ->Json;
				{"erlang term", Data} -> {ok, Data}
			catch
				Catch:Why ->
					?trace( [Catch, Why] ),
					"{\"state\":\"101\", \"msg\":\"code crash\"}" 
			end;
		{Event, Module} ->			
			case check( Args ) of
				{error, Error} ->
					Error;
				{ok, NewArgs} ->
					try Module:handle( NewArgs ) of
						{ok, Json} -> rfc4627:encode( {obj, [{"state", 200}, {"msg", Json}]} );
						{error, Reason} -> "{\"state\":\"103\", \"msg\":\""++Reason++"\"}"
					catch
						Catch:Why ->
							?trace( [Catch, Why] ),
							"{\"state\":\"101\", \"msg\":\"code crash\"}" 
					end	
			end;
		false ->
			?trace( Event ),
			"{\"state\":\"202\", \"msg\":\"no this event\"}" 
	end.

check( Args ) ->
	case gm_fun:read_config() of
		{error, Other} -> {error, Other};
		{ok, [[_ServerList, GameMsg, PlatMsg]]} ->
			ServerId = element( 2, Args ),
			PlatformId = element( 3, Args ),
			case lists:keyfind(ServerId, 1, GameMsg) of
					false -> 
						?trace( "no this game_server" ),
						{error, "{\"state\":\"202\", \"msg\":\"no this game_server_id\"}"};
					{ServerId, _Name, _A1, _A2, _A3, _A4, _A5} ->
						case lists:keyfind(PlatformId, 1, PlatMsg) of
							false -> 
								?trace( "no this platformId" ),
								{error, "{\"state\":\"202\", \"msg\":\"no this PlatformId\"}"};
							{_PlatformId, _Des} ->
								{ok, Args}
						end
			end
	end.
