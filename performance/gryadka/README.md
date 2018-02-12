Perseus/Gryadka is a set of scripts to investigate responsiveness of a Gryadka cluster when its node is separated from the peers.

The scripts measure an impact from a client's perspective by opening a connection to every node of the cluster, incrementing a value per each of them and dumping the statistics every second.

All scripts are dockerized so it's painless to reproduce the results.

## Output

A summary of `logs/client1.log` (gryadka: 1.61.8, redis: 4.0.1):

<pre>#legend: time|gryadka1|gryadka2|gryadka3|gryadka1:err|gryadka2:err|gryadka3:err
1	128	175	166	0	0	0	2018/01/16 09:02:41
2	288	337	386	0	0	0	2018/01/16 09:02:42
...
18	419	490	439	0	0	0	2018/01/16 09:02:58
19	447	465	511	0	0	0	2018/01/16 09:02:59
# isolating gryadka1
20	474	461	405	0	0	0	2018/01/16 09:03:00
# isolated gryadka1
21	108	577	596	0	0	0	2018/01/16 09:03:01
22	0	850	823	0	0	0	2018/01/16 09:03:02
23	0	699	767	0	0	0	2018/01/16 09:03:03
...
43	0	756	346	0	0	0	2018/01/16 09:03:23
# rejoining gryadka1
44	0	847	733	0	0	0	2018/01/16 09:03:24
# rejoined gryadka1
45	0	644	800	0	0	0	2018/01/16 09:03:25
...
48	0	789	871	0	0	0	2018/01/16 09:03:28
49	155	516	710	0	0	0	2018/01/16 09:03:29
50	381	460	428	0	0	0	2018/01/16 09:03:30</pre>

The first column is the number of second since the begining of the experiment, the following three columns represent the number of increments per each node of the cluster per second, the next triplet is number of errors per second and the last is time.

The all zero row means that all connections hang.

## How to use Perseus?

Clone this repository:

    git clone https://github.com/rystsov/perseus.git

Switch to gryadka folder:

    cd perseus/gryadka

Run the gryadka cluster (3 nodes):

    docker-compose up

Open new tab, build and run a client's container

    ./build-client.sh && ./run-client1.sh

You'll see an output similar to `logs/client1.log` but without isolating/rejoin markers (the log still has them).

Then use the `./isolate.sh gryadka1` to isolate `gryadka1` (you can use `gryadka2`, `gryadka3` too). To rejoin `gryadka1` to the cluster use  `./rejoin.sh gryadka1`