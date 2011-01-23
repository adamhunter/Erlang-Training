-module (cache_web).

-export ([start/1, dispatch/1]).

start(Port) ->
  gen_cache:start_link(),
  mochiweb_http:start([{port, Port}, {loop, fun dispatch/1}]).
    
dispatch(Req) ->
  Params = Req:parse_qs(),
  Key    = proplists:get_value("key", Params),
  case Req:get(method) of
    'GET' ->
      case gen_cache:get(Key) of
        {error, not_found} ->
          Response = {404, [{"Content-Type", "text/plain"}], "Not Found"};
        Value ->
          Res = io_lib:format("The key's (~p) value is ~p~n", [Key,Value]),
          Response = {200, [{"Content-Type", "text/plain"}], Res}
      end;
    'POST' ->
      Value = proplists:get_value("value", Params),
      gen_cache:add(Key, Value),
      Res = io_lib:format("You've added ~p with the value ~p", [Key, Value]),
      Response = {200, [{"Content-Type", "text/plain"}], Res};
    'DELETE' ->
      gen_cache:remove(Key),
      Res = io_lib:format("You've delete the key: ~p", [Key]),
      Response = {200, [{"Content-Type", "text/plain"}], Res}
  end,
  Req:respond(Response).  