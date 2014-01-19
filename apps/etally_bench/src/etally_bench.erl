-module(etally_bench).

-export([start/0]).

-spec start() -> ok.
start() ->

    ok = application:start(etally_bench).
