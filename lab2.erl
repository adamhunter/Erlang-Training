-module(lab2).

%-export([fizzbuzz/1, map_fizzbuzz/1, map_fizzbuzz_big/1, fibber/1]).
-export ([export_all]).

fb_iterate(List) ->
  receive
    {response, Caller, W} ->
    
  end
  
fb_translate() ->
  receive
    {evaluate, Caller, N} ->
      Caller ! {response, self(), fizzbuzz(N)}
  end

fb_run(List) ->
  Iterator   = spawn(),
  Translator = spawn(),
  Iterator ! {start, Translator, List}


map_fizzbuzz(List) ->
  [fizzbuzz(I) || I <- List].

map_fizzbuzz_big(List) ->
  map_fizzbuzz_big(List, []).
  
map_fizzbuzz_big([], Accum) ->
  lists:reverse(Accum);
map_fizzbuzz_big([H|T], Accum) ->
  map_fizzbuzz_big(T, [fizzbuzz(H) | Accum]).

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


%% when recurssing you need a termination case function 
%% variant so that when the list runs out of items
%% the function will return ok.
print_all([]) ->
  ok;
%% [H | T] is head and tail notation.  pop the first item |
%% off of the list and assign it to H (tail), then put the remainder
%% of the list into T (tail).
print_all([H | T]) ->
  io:format("~p~n", [H]),
  print_all(T).
  
  
