-module (math_server).
-compile([export_all]).

add(ServerPid, X, Y) ->
  ServerPid ! {add, X, Y, self()},
  receive
    {result, Result} ->
      Result
    after 100 -> 
      {error, timeout}  
  end.

sub(ServerPid, X, Y) ->
  ServerPid ! {subtract, X, Y, self()},
  receive
    {result, Result} ->
      Result
    after 100 ->
      {error, timeout}
  end.

init() ->
  %% startup
  spawn(fun() -> loop(dict:new()) end).
  
loop(State) ->
  Response = receive
    stop ->
      stop(State),
      ok;
    {add, X, Y, Caller} ->
      {compute_add(X, Y, State), Caller};
    {subtract, X, Y, Caller} ->
      {compute_subtract(X, Y, State), Caller}
  end,
  case Response of
    ok ->
      ok;
    {{result, Result, Cache}, NewCaller} ->
      NewCaller ! {result, Result},
      loop(Cache)
  end.
  
stop(_State) ->
  %% cleanup
  ok.

shutdown(ServerPid) ->  
  ServerPid ! stop,
  ok.
  
compute_add(X, Y, Cache) ->
  case dict:find({X, Y, add}, Cache) of
    error ->
      Result = X + Y,
      {result, Result, dict:store({X, Y, add}, Result, Cache)};
    {ok, Result} ->
      {result, Result, Cache}
  end.

compute_subtract(X, Y, Cache) ->
  case dict:find({X, Y, sub}, Cache) of
    error ->
      Result = X - Y,
      {result, Result, dict:store({X, Y, sub}, Result, Cache)};
    {ok, Result} ->
      {result, Result, Cache}
  end.