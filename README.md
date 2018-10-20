# CASPaxos

CASPaxos is a wait-free, linearizable, multi-writer multi-reader register in unreliable, asynchronous networks supporting arbitrary update operations including compare-and-set (CAS). The register acts as a replicated state machine providing an interface for changing its value by applying an arbitrary user-provided function (a command). Unlike Multi-Paxos and Raft which replicate the log of commands, CASPaxos replicates state, thus avoiding associated complexity, reducing write amplification, increasing concurrency of disk operations and hardware utilization.
    
The paper describes CASPaxos, proves its safety properties and evaluates the characteristics of a CASPaxos-based prototype of key-value storage.

## Paper

https://github.com/rystsov/caspaxos/blob/master/latex/caspaxos.pdf

## Implementations

The algorithm is new so most implementations are actively being developed. 

 * https://github.com/gryadka/js
 * https://github.com/peterbourgon/caspaxos
 * https://github.com/spacejam/sled/tree/master/crates/paxos
 * https://github.com/ericentin/caspax
 * https://github.com/ReubenBond/orleans/tree/poc-caspaxos
 * https://github.com/komuw/kshaka

## Talks
 * [Papers We Love SF: Peter Bourgon on CASPaxos](https://www.youtube.com/watch?v=TW2OPHdIKsM)

## Articles

 * [Paxos on Steroids and a Crash Course in TLA+](https://tschottdorf.github.io/single-decree-paxos-tla-compare-and-swap)
 * [A TLA+ specification for Gryadka](https://medium.com/@grogepodge/tla-specification-for-gryadka-c80cd625944e)
 * [A Proof of Correctness for CASPaxos](http://justinjaffray.com/blog/posts/2018-04-10-caspaxos/)
 * [Ben Linsay on CASPaxos](https://medium.com/@blinsay/caspaxos-a8f6b3cf5515)
 * [Описание CASPaxos на русском](https://github.com/eshlykov/distributed-computing-course/blob/1c1a117a63c4b625e8ecf31e76c299efd5da3852/caspaxos.md)
 * [Exploring consensus via python and CASPaxos](https://www.komu.engineer/blogs/consensus)
