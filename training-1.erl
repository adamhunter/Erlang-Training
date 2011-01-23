
% Example 1.1
Example = [1,2,3,4,5].
[X + 1 || X <- Example].

% Example 1.2
Words = ["no", "soup", "for", "you"].
[X || X <- Words, X /= "soup"].

% Example 2.1
% blech version (don't use if, use switch)
even_or_odd(N) ->
  if
    N rem 2 == 0 ->
      even;
    true ->
      odd
  end.
  
even_or_odd(N) when N rem 2 == 0 ->
  even;
even_or_odd(_N) ->
  odd.


normalize(N) when is_integer(N), N > 100 ->
  100;
normalize(N) when is_integer(N) ->
  N.
  
.
A = "carrot".
B = ["apple", "bread"].
C = [A|B].
    