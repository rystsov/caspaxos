Perseus/Etcd is a set of scripts to investigate responsiveness of a Etcd cluster when its node is separated from the peers.

The scripts measure an impact from a client's perspective by opening a connection to every node of the cluster, incrementing a value per each of them and dumping the statistics every second.

All scripts are dockerized so it's painless to reproduce the results.

## Output

A summary of `logs/client1.log` (3.2.13):

<pre>#legend: time|etcd1|etcd2|etcd3|etcd1:err|etcd2:err|etcd3:err
1	58	56	54	0	0	0	2018/01/08 06:43:09
2	65	58	55	0	0	0	2018/01/08 06:43:10
...
18	65	58	56	0	0	0	2018/01/08 06:43:26
19	76	55	67	0	0	0	2018/01/08 06:43:27
# isolating etcd1
# isolated etcd1
20	27	26	26	0	0	0	2018/01/08 06:43:28
21	0	0	0	1	1	1	2018/01/08 06:43:29
22	0	43	47	1	1	1	2018/01/08 06:43:30
...
42	0	100	106	1	0	0	2018/01/08 06:43:50
43	0	96	112	1	0	0	2018/01/08 06:43:51
# rejoining etcd1
# rejoined etcd1
44	0	81	88	1	0	0	2018/01/08 06:43:52
45	0	0	0	1	1	1	2018/01/08 06:43:53
46	12	19	21	1	0	0	2018/01/08 06:43:54
47	67	64	65	0	0	0	2018/01/08 06:43:55</pre>

The first column is the number of second since the begining of the experiment, the following three columns represent the number of increments per each node of the cluster per second, the next triplet is number of errors per second and the last is time.

The all zero row means that all connections hang.

## How to use Perseus?

Clone this repository:

    git clone https://github.com/rystsov/perseus.git

Switch to Etcd folder:

    cd perseus/etcd

Run the etcd cluster (3 nodes):

    docker-compose up

Open new tab, build and run a client's container

    ./build-client.sh && ./run-client1.sh

You'll see an output similar to `logs/client1.log` but without isolating/rejoin markers (the log still has them).

Then use the `./isolate.sh etcd1` to isolate `etcd1` (you can use `etcd2`, `etcd3` too). To rejoin `etcd1` to the cluster use  `./rejoin.sh etcd1`