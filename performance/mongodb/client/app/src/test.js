const {RemoteTesterClient} = require("./RemoteTesterClient");
const {TestAggregator} = require("./TestAggregator");

const nodes = [ ];

for (const [host, port] of [["mongo1", 2379],["mongo2", 2379],["mongo3", 2379]]) {
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
