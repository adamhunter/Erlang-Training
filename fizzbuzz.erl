-module (fizzbuzz).

-compile ([export_all]).

% Kick off function, spawn iterator
start() ->
  Pid = spawn(fun() -> translator() end),
  iterate(Pid, lists:seq(1,100)).

translator() ->
  receive
    {evaluate, Caller, N} ->
      Caller ! {translation, fizzbuzz(N)},
      translator();
    stop ->
      ok
  end.
  
iterate(Pid, []) ->
  Pid ! stop,
  ok;
iterate(Pid, [H|T]) ->
  Pid ! {evaluate, self(), H},
  receive
    {translation, V} ->
      io:format("Tranlated ~p into ~p\n", [H, V]),
      iterate(Pid, T)
  end.


% fizzbuzz does the actual translation
fizzbuzz(N) when is_integer(N), 
                 N rem 15 == 0 ->
  fizzbuzz;
fizzbuzz(N) when is_integer(N), 
                 N rem 3 == 0 ->
  fizz;
fizzbuzz(N) when is_integer(N), 
                 N rem 5 == 0 ->
  buzz;
fizzbuzz(N) ->
  N.       
