const {GryadkaKV} = require("./GryadkaKV");
const {RemoteTesterServer} = require("./RemoteTesterServer");

const fs = require("fs");

const cluster = JSON.parse(fs.readFileSync(process.argv[2]));
const proposerId = process.argv[3];

const proposer = cluster.proposers[proposerId];
const settings = {
    id: proposer.id,
    port: proposer.port,
    quorum: proposer.quorum,
    acceptors: proposer.acceptors.map(aid => {
        return cluster.acceptors[aid];
    })
};

console.info(settings);

const kv = new GryadkaKV(settings);
kv.start();

const service = new RemoteTesterServer(
    kv,
    8000
);
service.start();
