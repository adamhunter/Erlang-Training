-module(demo).

-export([hello/1]).

hello(Name) -> 
  io:format("Hello, ~s!~n", [Name]).