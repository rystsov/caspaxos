#!/bin/bash

set -e

apt-get install -y software-properties-common
add-apt-repository -y ppa:gophers/archive
apt-get update -y
apt-get install -y golang-1.9-go

mkdir /mnt/etcd
ln -s /mnt/etcd /etcd

pushd /etcd

mkdir mem

wget https://github.com/coreos/etcd/releases/download/v3.2.13/etcd-v3.2.13-linux-amd64.tar.gz
tar -xzvf etcd-v3.2.13-linux-amd64.tar.gz
rm etcd-v3.2.13-linux-amd64.tar.gz
cp -r /scripts/caspaxos/performance/etcd/db/remote-tester /etcd/remote-tester
/etcd/remote-tester/build.sh
cp /scripts/caspaxos/performance/etcd/db/run-etcd.sh /etcd/run-etcd.sh
cp /scripts/caspaxos/performance/etcd/db/run-tester.sh /etcd/run-tester.sh
cp /scripts/caspaxos/performance/etcd/db/isolate.sh /etcd/isolate.sh
cp /scripts/caspaxos/performance/etcd/db/rejoin.sh /etcd/rejoin.sh
cp /scripts/caspaxos/performance/etcd/db/etcd.conf /etc/supervisor/conf.d/etcd.conf

popd
