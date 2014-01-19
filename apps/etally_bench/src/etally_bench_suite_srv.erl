-module(etally_bench_suite_srv).

-behaviour(gen_server).

-export([start_link/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, code_change/3, terminate/2]).


-record(state, {}).



test_count_inserts(Instance) ->
    lager:info(" -= COUNTS =- "),
    Fun = fun(0, _F) -> ok;
             (X, F) ->
                  etally_count:send_event([<<"test_event">>], [{<<"test_event">>, <<"test_leaderboard">>}], Instance),
                  F(X-1, F)
          end,

    _ = [begin
             Scaled_X = 1000*X,
             {Time, _Res} = timer:tc(fun () ->
                                             ok = Fun(Scaled_X, Fun),
                                             _ = etally_count:get_counter(<<"test_event">>, Instance)
                                    end),
             lager:info("~p inserts w. leaderboard in ~p mics -\t ~.2f ops/sec", [Scaled_X, Time, Scaled_X*1000000.0/Time] )
         end || X <- lists:seq(1,10)],
    ok.


test_count_inserts_multi5(Instance) ->
    lager:info(" -= COUNTS MULTI 5 =- "),
    Fun = fun(0, _F) -> ok;
             (X, F) ->
                  etally_count:send_event([<<"test_event1">>, <<"test_event2">>, <<"test_event3">>, <<"test_event4">>, <<"test_event5">>],
                                          [{<<"test_event1">>, <<"test_leaderboard">>}, 
                                           {<<"test_event2">>, <<"test_leaderboard">>},
                                           {<<"test_event3">>, <<"test_leaderboard">>},
                                           {<<"test_event4">>, <<"test_leaderboard">>},
                                           {<<"test_event5">>, <<"test_leaderboard">>}], Instance),
                  F(X-1, F)
          end,

    _ = [begin
             Scaled_X = 1000*X,
             {Time, _Res} = timer:tc(fun () ->
                                            ok = Fun(Scaled_X, Fun),
                                            _ = etally_count:get_counter(<<"test_event1">>, Instance)
                                    end),
             lager:info("~p inserts w. leaderboard in ~p mics -\t ~.2f ops/sec", [Scaled_X, Time, Scaled_X*1000000.0/Time] )
         end || X <- lists:seq(1,10)],
    %% {Time, Res} = timer:tc(fun () ->
    %%                                ok = Fun(1000000, Fun),
    %%                                _ = etally_count:get_counter(<<"test_event">>, Instance)
    %%                        end),
    %% lager:info("~p inserts w. leaderboard in ~p mics -\t ~.2f ops/sec", [1000000, Time, 1000000*1000000.0/Time] ),
    ok.



test_metric_inserts(Instance) ->
    lager:info(" -= METRICS =- "),
    Fun = fun(0, _F) -> ok;
             (X, F) ->
                  etally_metric:send_event([<<"test_event">>], [{<<"test_event">>, <<"test_leaderboard">>}], [<<"test_event">>], 100, Instance),
                  F(X-1, F)
          end,
    _ = [begin
             Scaled_X = 1000*X,
             {Time, _Res} = timer:tc(fun () ->
                                            ok = Fun(Scaled_X, Fun),
                                            _ = etally_metric:get_counter(<<"test_event">>, Instance)
                                    end),
             lager:info("~p inserts w. leaderboard in ~p mics -\t ~.2f ops/sec", [Scaled_X, Time, Scaled_X*1000000.0/Time] )
         end || X <- lists:seq(1,10)],
    ok.
    

test_metric_inserts_multi5(Instance) ->
    lager:info(" -= METRICS MULTI 5 =- "),
    Fun = fun(0, _F) -> ok;
             (X, F) ->
                  etally_metric:send_event([<<"test_event1">>, <<"test_event2">>, <<"test_event3">>, <<"test_event4">>, <<"test_event5">>],
                                           [{<<"test_event1">>, <<"test_leaderboard">>}, 
                                            {<<"test_event2">>, <<"test_leaderboard">>},
                                            {<<"test_event3">>, <<"test_leaderboard">>},
                                            {<<"test_event4">>, <<"test_leaderboard">>},
                                            {<<"test_event5">>, <<"test_leaderboard">>}], 
                                           [<<"test_event1">>, <<"test_event2">>, <<"test_event3">>, <<"test_event4">>, <<"test_event5">>],123, Instance),
                  F(X-1, F)
          end,
    _ = [begin
             Scaled_X = 1000*X,
             {Time, _Res} = timer:tc(fun () ->
                                            ok = Fun(Scaled_X, Fun),
                                            _ = etally_metric:get_counter(<<"test_event">>, Instance)
                                    end),
             lager:info("~p inserts w. leaderboard in ~p mics -\t ~.2f ops/sec", [Scaled_X, Time, Scaled_X*1000000.0/Time] )
         end || X <- lists:seq(1,10)],
    ok.
    

test_metric_inserts_multi10(Instance) ->
    lager:info(" -= METRICS MULTI 10 =- "),
    Fun = fun(0, _F) -> ok;
             (X, F) ->
                  etally_metric:send_event([<<"test_event_0">>, <<"test_event_1">>, <<"test_event_2">>, <<"test_event_3">>, <<"test_event_4">>,
                                            <<"test_event_5">>, <<"test_event_6">>, <<"test_event_7">>, <<"test_event_8">>, <<"test_event_9">>],
                                           [{<<"test_event_0">>, <<"test_leaderboard_1">>}, 
                                            {<<"test_event_1">>, <<"test_leaderboard_1">>},
                                            {<<"test_event_2">>, <<"test_leaderboard_1">>},
                                            {<<"test_event_3">>, <<"test_leaderboard_1">>},
                                            {<<"test_event_4">>, <<"test_leaderboard_1">>},
                                            {<<"test_event_5">>, <<"test_leaderboard_1">>}, 
                                            {<<"test_event_6">>, <<"test_leaderboard_1">>},
                                            {<<"test_event_7">>, <<"test_leaderboard_1">>},
                                            {<<"test_event_8">>, <<"test_leaderboard_1">>},
                                            {<<"test_event_9">>, <<"test_leaderboard_1">>}], 
                                           [<<"test_event_0">>, <<"test_event_1">>, <<"test_event_2">>, <<"test_event_3">>, <<"test_event_4">>,
                                            <<"test_event_5">>, <<"test_event_6">>, <<"test_event_7">>, <<"test_event_8">>, <<"test_event_9">>]
                                           ,123, Instance),
                  F(X-1, F)
          end,
    _ = [begin
             Scaled_X = 1000*X,
             {Time, _Res} = timer:tc(fun () ->
                                            ok = Fun(Scaled_X, Fun),
                                            _ = etally_metric:get_counter(<<"test_event">>, Instance)
                                    end),
             lager:info("~p inserts w. leaderboard in ~p mics -\t ~.2f ops/sec", [Scaled_X, Time, Scaled_X*1000000.0/Time] )
         end || X <- lists:seq(1,10)],
    
    Large_Number = 1000000,
    {Time, _Res} = timer:tc(fun () ->
                                   ok = Fun(Large_Number, Fun),
                                   _ = etally_metric:get_counter(<<"test_event">>, Instance)
                           end),
    lager:info("~p inserts w. leaderboard in ~p mics -\t ~.2f ops/sec", [Large_Number, Time, Large_Number*1000000.0/Time] ),
    


    ok.
    




start_link(Args) -> gen_server:start_link({local, ?MODULE}, ?MODULE, Args, []).

init([]) ->
    %% test before start command,
    {ok,Instance} = application:get_env(etally_bench, etally_instance),
    io:fwrite("working with node : ~p~n", [Instance]),
    {any, 'tally@msk-dev.local'} ! {cast, self(), {system_start} },
    test_metric_inserts_multi10(Instance),
    test_metric_inserts_multi5(Instance),
    test_metric_inserts(Instance),
    test_count_inserts_multi5(Instance),
    test_count_inserts(Instance),
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

terminate(_Reason, _State) ->
    ok.

