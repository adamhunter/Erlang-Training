-module (ping).

-compile([export_all]).

ping(End) ->
  receive
    {ping, Caller, End} ->
      io:format("Reached ~p in ~p, telling ~p to stop!\n", [End, self(), Caller]),
      Caller ! stop,
      ok;
    {ping, Caller, N} ->
      Caller ! {ping, self(), N + 1},
      io:format("Ping ~p in ~p!\n", [N, self()]),
      ping(End);
    stop ->
      ok
  end.
  
pong() ->
  Ping = spawn(fun() -> ping(50) end),
  Pong = spawn(fun() -> ping(50) end),
  Ping ! {ping, Pong, 0}.
  
  
pong2({start, Start, finish, End}) ->
  Ping = spawn(ping, ping, [End]),
  Pong = spawn(ping, ping, [End]),
  Ping ! {ping, Pong, Start}.
  
pong3({start, Start, finish, End}) ->
  Ping = spawn(ping, ping, [End]),
  spawn(fun() ->
    Ping ! {ping, self(), Start},
    ping() end).
