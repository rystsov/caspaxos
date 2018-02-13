#!/bin/bash

set -e

curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install -y nodejs

mkdir /mnt/mongo
ln -s /mnt/mongo /mongo

pushd /mongo

mkdir mem

wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.6.1.tgz
tar -xzvf mongodb-linux-x86_64-3.6.1.tgz
rm mongodb-linux-x86_64-3.6.1.tgz

cp -r /scripts/caspaxos/performance/mongodb/db/remote-tester /mongo/remote-tester

cp /scripts/caspaxos/performance/mongodb/db/run-mongo.sh /mongo/run-mongo.sh
cp /scripts/caspaxos/performance/mongodb/db/run-tester.sh /mongo/run-tester.sh
cp /scripts/caspaxos/performance/mongodb/db/topology /mongo/topology
cp /scripts/caspaxos/performance/mongodb/db/isolate.sh /mongo/isolate.sh
cp /scripts/caspaxos/performance/mongodb/db/rejoin.sh /mongo/rejoin.sh
cp /scripts/caspaxos/performance/mongodb/db/mongo.conf /etc/supervisor/conf.d/mongo.conf

pushd /mongo/remote-tester
npm install

popd
popd