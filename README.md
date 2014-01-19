etally_bench
============

Test Suite for etally,

Instructions:
-----

Start etally locally on your machine, 
Set the etally parameter in the app.config,

and run:

make shell

At the moment this yields the following on my local laptop, meaning that etally can handle arround 82.000 events per second.

```
21:45:49.992 [info] Application lager started on node 'etally_bench@msk-dev.local'
1000 inserts in 326996 mics - 3058.141383992465 ops/sec
2000 inserts in 27638 mics - 72364.13633403285 ops/sec
3000 inserts in 41019 mics - 73136.8390258173 ops/sec
4000 inserts in 52962 mics - 75525.84872172501 ops/sec
5000 inserts in 83699 mics - 59737.87022545072 ops/sec
6000 inserts in 85505 mics - 70171.33500964855 ops/sec
7000 inserts in 85559 mics - 81814.88797204268 ops/sec
8000 inserts in 96150 mics - 83203.32813312532 ops/sec
9000 inserts in 108914 mics - 82634.0048111354 ops/sec
10000 inserts in 137160 mics - 72907.55322251386 ops/sec
1000 inserts w. leaderboard in 14462 mics - 69146.72935970129 ops/sec
2000 inserts w. leaderboard in 27158 mics - 73643.12541424258 ops/sec
3000 inserts w. leaderboard in 41668 mics - 71997.69607372564 ops/sec
4000 inserts w. leaderboard in 48395 mics - 82653.16664944726 ops/sec
5000 inserts w. leaderboard in 69037 mics - 72424.93155843968 ops/sec
6000 inserts w. leaderboard in 79427 mics - 75541.06286275448 ops/sec
7000 inserts w. leaderboard in 89696 mics - 78041.38423118088 ops/sec
8000 inserts w. leaderboard in 98401 mics - 81299.98678875215 ops/sec
9000 inserts w. leaderboard in 108250 mics - 83140.87759815242 ops/sec
10000 inserts w. leaderboard in 175612 mics - 56943.716830284946 ops/sec
```

