# CASPaxos

CASPaxos is a replicated state machine (RSM) protocol, an extension of Synod. Unlike Raft and Multi-Paxos, it doesn't use leader election and log replication, thus avoiding associated complexity. Its symmetric peer-to-peer approach achieves optimal commit latency in wide-area networks and doesn't cause transient unavailability when any (N-1)/2 of N nodes crash.

The lightweight nature of CASPaxos allows new combinations of RSMs in the designs of distributed systems. For example, a representation of key-value storage as a hashtable with independent RSM per key increases fault tolerance and improves performance on multi-core systems compared with a hashtable behind a single RSM.

This paper describes CASPaxos protocol, formally proves its safety properties, covers cluster membership change and evaluates the benefits of CASPaxos-based key-value storage.

## Paper

https://github.com/rystsov/caspaxos/blob/master/latex/caspaxos.pdf

## Implementations

The algorithm is new so most implementations are actively being developed. 

 * (by author of the paper) https://github.com/gryadka/js
 * https://github.com/peterbourgon/caspaxos
 * https://github.com/ericentin/caspax
 * https://github.com/ReubenBond/orleans/tree/poc-caspaxos
 * https://github.com/spacejam/sled/tree/tyler_paxos

## Articles

 * [Paxos on Steroids and a Crash Course in TLA+](https://tschottdorf.github.io/single-decree-paxos-tla-compare-and-swap)
 * [A TLA+ specification for Gryadka](https://medium.com/@grogepodge/tla-specification-for-gryadka-c80cd625944e)
* [Exploring consensus via python and CASPaxos](https://www.komu.engineer/blogs/consensus)
