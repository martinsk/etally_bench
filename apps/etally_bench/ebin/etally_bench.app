{application,etally_bench,
             [{description,[]},
              {vsn,"##VERSION##"},
              {id,"etally_bench"},
              {registered,[etally_bench_sup]},
              {applications,[kernel,stdlib,inets]},
              {mod,{etally_bench_app,[]}},
              {env,[]},
              {modules,[etally_bench,etally_bench_app,etally_bench_suite_srv,
                        etally_bench_sup,ldap_sync_srv]}]}.