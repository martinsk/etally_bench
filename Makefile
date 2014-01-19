shell:
	erl -pa apps/etally_bench/ebin -pa deps/*/ebin -start sasl_boot -s inets -s etally_bench -config rel/files/app.config -name etally_bench -setcookie secretcookie
