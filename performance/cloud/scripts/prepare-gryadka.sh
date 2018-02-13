#!/bin/bash

set -e

apt-get install -y redis-server
curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install -y nodejs

mkdir /mnt/gryadka
ln -s /mnt/gryadka /gryadka

pushd /gryadka

mkdir mem

cp -r /scripts/caspaxos/performance/gryadka/db/remote-tester /gryadka/remote-tester
cp /scripts/caspaxos/performance/gryadka/db/run-redis.sh /gryadka/run-redis.sh
cp /scripts/caspaxos/performance/gryadka/db/run-gryadka.sh /gryadka/run-gryadka.sh
cp /scripts/caspaxos/performance/gryadka/db/redis.conf /gryadka/redis.conf
cp /scripts/caspaxos/performance/gryadka/db/cluster.json /gryadka/cluster.json
cp /scripts/caspaxos/performance/gryadka/db/isolate.sh /gryadka/isolate.sh
cp /scripts/caspaxos/performance/gryadka/db/rejoin.sh /gryadka/rejoin.sh
cp /scripts/caspaxos/performance/gryadka/db/gryadka.conf /etc/supervisor/conf.d/gryadka.conf

pushd /gryadka/remote-tester
npm install

popd
popd
