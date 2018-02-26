const {MongoKV} = require("./MongoKV");
const {RemoteTesterServer} = require("./RemoteTesterServer");

const service = new RemoteTesterServer(
    new MongoKV("mongodb://node1,node2,node3/?replicaSet=rs0&autoReconnect=false&socketTimeoutMS=10000&connectTimeoutMS=10000"),
    2379
);
service.start();
