%% @author 余健
%% @doc pub function

-module(gm_pub_function).
-include( "basic_data.hrl" ).
-include( "table_record.hrl" ).
-export([record_data/3]).

record_data( TableName, TableIndexs, TableRecord ) ->
	Record = list_to_tuple([TableName|TableRecord]),
	Fun = fun( {Key, Index, false} ) -> {Key, Index};
			 	  ( {Key, Index, basic} ) -> {Key, basic_data( TableName, Index, Record )};
			 	  ( {Key, Function, Arg} ) -> {Key, db_data( Function, Arg )};
			 	  ( {Key, Index, time, Action} ) ->{Key, db_data( time, [element( Index, Record ), Action] )};
			 	  ( {Key, Index}) -> {Key, element( Index, Record )}
		  	 end,
	lists:map( Fun, TableIndexs ).
	

basic_data( TableName, TableIndex, Record ) -> 
	case lists:keyfind( {TableName, TableIndex, element( TableIndex, Record )}, 1, ?BASIC_DATA ) of
		false -> "";
		{_, Value} -> Value
	end.

db_data( Function, Arg ) ->
	gm_mod_manager:Function(Arg).