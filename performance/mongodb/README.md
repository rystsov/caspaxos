Perseus/MongoDB is a set of scripts to investigate responsiveness of a MongoDB cluster when its node is separated from the peers.

The scripts measure an impact from a client's perspective by opening a connection to every node of the cluster, incrementing a value per each of them and dumping the statistics every second.

All scripts are dockerized so it's painless to reproduce the results.

## Output

A summary of `logs/client1.log` (v3.6.1 - 025d4f4fe61efd1fb6f0005be20cb45a004093d1):

<pre>#legend: time|mongo1|mongo2|mongo3|mongo1:err|mongo2:err|mongo3:err
1	24	19	24	0	0	0	2018/01/11 07:30:29
2	30	22	33	0	0	0	2018/01/11 07:30:30
...
10	32	21	31	0	0	0	2018/01/11 07:30:38
11	30	20	31	0	0	0	2018/01/11 07:30:39
# isolating mongo1
# isolated mongo1
12	10	7	11	0	0	0	2018/01/11 07:30:40
13	0	0	0	1	1	1	2018/01/11 07:30:41
...
39	0	0	0	1	1	1	2018/01/11 07:31:07
40	0	0	0	1	1	1	2018/01/11 07:31:08
41	0	26	22	1	1	1	2018/01/11 07:31:09
42	0	46	39	1	0	0	2018/01/11 07:31:10
...
74	0	55	41	1	0	0	2018/01/11 07:31:42
75	0	52	40	1	0	0	2018/01/11 07:31:43
# rejoining mongo1
# rejoined mongo1
76	0	51	34	1	0	0	2018/01/11 07:31:44
77	21	41	32	1	0	0	2018/01/11 07:31:45</pre>

The first column is the number of second since the begining of the experiment, the following three columns represent the number of increments per each node of the cluster per second, the next triplet is number of errors per second and the last is time.

The all zero row means that all connections hang.

## How to use Perseus?

Clone this repository:

    git clone https://github.com/rystsov/perseus.git

Switch to mongodb folder:

    cd perseus/mongodb

Run the mongodb cluster (3 nodes):

    docker-compose up

Open new tab, build and run a client's container

    ./build-client.sh && ./run-client1.sh

You'll see an output similar to `logs/client1.log` but without isolating/rejoin markers (the log still has them).

Then use the `./isolate.sh mongodb1` to isolate `mongodb1` (you can use `mongodb2`, `mongodb3` too). To rejoin `mongodb1` to the cluster use  `./rejoin.sh mongodb1`