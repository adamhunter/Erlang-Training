-module (simple_math).
-compile([export_all]).

%% Public Api
start() ->
  gen_cache:start_link(),
  simple_server:start(?MODULE).
  
add(ServerPid, X, Y) ->
  simple_server:call(ServerPid, {add, X, Y}).

sub(ServerPid, X, Y) ->
  simple_server:call(ServerPid, {sub, X, Y}).

%% Server Callbacks
on_init() ->
  {ok, dict:new()}.
  
on_message({add, X, Y}, State) -> 
  manage_cache({X, Y, add}, State, fun() -> X + Y end);
on_message({sub, X, Y}, State) ->
  manage_cache({X, Y, sub}, State, fun() -> X - Y end).
  
on_terminate() ->
  ok.
  
manage_cache(Key, State, Miss) ->
  case gen_cache:get(Key) of
    {error, not_found} ->
      io:format("Cache Miss~n"),
      Result = Miss(),
      gen_cache:add(Key, Result),
      {reply, Result, State};
    Result ->
      io:format("Cache Hit~n"),
      {reply, Result, State}
    end.
