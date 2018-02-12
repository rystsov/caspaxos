const {MongoKV} = require("./MongoKV");
const {RemoteTesterServer} = require("./RemoteTesterServer");

const service = new RemoteTesterServer(
    new MongoKV("mongodb://mongo1,mongo2,mongo3/?replicaSet=rs0&autoReconnect=false&socketTimeoutMS=10000&connectTimeoutMS=10000"),
    2379
);
service.start();
