const {RemoteTesterClient} = require("./RemoteTesterClient");
const {TestAggregator} = require("./TestAggregator");

const nodes = [ ];

for (const [host, port] of [["gryadka1", 2379],["gryadka2", 2379],["gryadka3", 2379]]) {
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
