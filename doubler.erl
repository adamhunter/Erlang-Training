
-module (doubler).
-export ([doubler/1]).

doubler(Data) ->
  [X * 2 || X <- Data].

doubler(Data) ->
  doubler(Data, []).
  
doubler([], Accum) ->
  lists:reverse(Accum);
doubler([H|T], Accum) ->
  doubler(T, [H * 2 | Accum]).
  