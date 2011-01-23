-module (gen_cache).

-behaviour (gen_server).

-export([start_link/0, add/2, remove/1, get/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {dict}).

start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

add(Key, Value) ->
  gen_server:cast(?MODULE, {add, Key, Value}).
  
remove(Key) ->
  gen_server:cast(?MODULE, {remove, Key}).
  
get(Key) ->
  gen_server:call(?MODULE, {get, Key}).

init([]) ->
  io:format("Starting ~p~n", [?MODULE]),
  {ok, #state{dict=dict:new()}}.


%% Add and Remove CASTS!!!  
handle_cast({add, Key, Value}, State) ->
  #state{dict=Dictionary} = State,
  NewState = State#state{dict=dict:store(Key, Value, Dictionary)},
  {noreply, NewState};

handle_cast({remove, Key}, State) ->
  #state{dict=Dictionary} = State,
  NewState = State#state{dict=dict:erase(Key, Dictionary)},
  {noreply, NewState};
  
handle_cast(_Msg, State) ->
  {noreply, State}.
  

%% Get CALLS!!!
handle_call({get, Key}, _From, State) ->
  #state{dict=Dictionary} = State,
  case dict:find(Key, Dictionary) of
    error ->
      {reply, {error, not_found}, State};
    {ok, Value} ->
      {reply, Value, State}
  end;

handle_call(_Request, _From, State) ->
  {reply, ignored, State}.
  
  
handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.
  