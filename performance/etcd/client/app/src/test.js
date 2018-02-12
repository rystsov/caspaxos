const {RemoteTesterClient} = require("./RemoteTesterClient");
const {TestAggregator} = require("./TestAggregator");

const nodes = [ ];

for (const [host, port] of [["etcd1", 8000],["etcd2", 8000],["etcd3", 8000]]) {
    nodes.push(new RemoteTesterClient(host, port));
}

const test = new TestAggregator(nodes, 1000);

(async () => {
    try {
        await test.run();
    } catch(e) {
        console.info("WAT?!");
        console.info(e);
    }
})();
