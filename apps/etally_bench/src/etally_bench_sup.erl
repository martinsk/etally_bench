
-module(etally_bench_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type),               {I,      {I,     start_link, []    }, permanent, 5000, Type,   [I]            }).
-define(CHILD(__Name, __Mod, __Args), {__Name, {__Mod, start_link, __Args}, permanent, 2000, worker, [__Mod]        }).
-define(SUPER(__Mod, __Args),         {__Mod,  {__Mod, start_link, __Args}, permanent, infinity, supervisor, [__Mod]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    Children = [?CHILD(etally_bench_suite_srv, etally_bench_suite_srv, [[]])],
    {ok, { {one_for_one, 5, 10}, Children} }.

