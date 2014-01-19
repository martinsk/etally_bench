-module(etally_bench_suite_srv).

-behaviour(gen_server).

-export([start_link/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, code_change/3, terminate/2]).


-record(state, {}).


start_link(Args) -> gen_server:start_link({local, ?MODULE}, ?MODULE, Args, []).

init([]) ->
    %% test before start command,
    {ok,Instance} = application:get_env(etally_bench, etally_instance),
    io:fwrite("working with node : ~p~n", [Instance]),
    _ = [begin
             Fun = fun(0, F) -> ok;
                      (X, F) ->
                           etally_count:send_event([<<"test_event">>], [{<<"test_event">>, <<"test_leaderboard_1">>}], Instance),
                           F(X-1, F)
                   end,
             Scaled_X = 1000*X,
             {Time, Res} = timer:tc(fun () ->
                                            ok = Fun(Scaled_X, Fun),
                                            _ = etally_count:get_counter(<<"test_event">>, Instance)
                                    end),
             io:fwrite("~p inserts in ~p mics - ~p ops/sec ~n", [Scaled_X, Time, Scaled_X*1000000.0/Time] )
         end || X <- lists:seq(1,10)],
    {any, 'tally@msk-dev.local'} ! {cast, self(), {system_start} },
    _ = etally_count:get_counter(<<"test_event">>, Instance),
    _ = [begin
             Fun = fun(0, F) -> ok;
                      (X, F) ->
                           etally_count:send_event([<<"test_event_2">>], [{<<"test_event_2">>, <<"test_leaderboard_2">>}], Instance),
                           F(X-1, F)
                   end,
             Scaled_X = 1000*X,
             {Time, Res} = timer:tc(fun () ->
                                            ok = Fun(Scaled_X, Fun),
                                            _ = etally_count:get_counter(<<"test_event_2">>, Instance)
                                    end),
             io:fwrite("~p inserts w. leaderboard in ~p mics - ~p ops/sec ~n", [Scaled_X, Time, Scaled_X*1000000.0/Time] )
         end || X <- lists:seq(1,10)],
    
    {ok, #state{}}.


handle_call(_Request, _From, State) ->
    {reply,"not implemented yet", State}.

handle_cast(stop, State) ->
    {stop, normal, State};
handle_cast(_Request, State) ->
    {noreply, State}.


handle_info(_, State) ->
    {reply,"not implemented yet", State}.

code_change(_OldVsn, State, _Extra) -> {ok, State}.

terminate(_Reason, State) ->
    ok.

