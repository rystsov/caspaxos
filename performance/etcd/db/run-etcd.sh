#!/bin/bash

me=$(hostname)

etcd1=$(getent hosts etcd1 | awk '{ print $1 }')
etcd2=$(getent hosts etcd2 | awk '{ print $1 }')
etcd3=$(getent hosts etcd3 | awk '{ print $1 }')

if [ -z "$etcd1" ] ; then exit 1 ; fi;
if [ -z "$etcd2" ] ; then exit 1 ; fi;
if [ -z "$etcd3" ] ; then exit 1 ; fi;

myip=$(getent hosts $me | awk '{ print $1 }')

cluster="etcd1=http://$etcd1:2380,etcd2=http://$etcd2:2380,etcd3=http://$etcd3:2380"
peer="http://$myip:2380"
client="http://$myip:2379"

/etcd/etcd-v3.2.13-linux-amd64/etcd \
  --heartbeat-interval=200 \
  --election-timeout=2000 \
  --data-dir "/etcd/mem/$me" \
  --name $me \
  --initial-advertise-peer-urls $peer \
  --listen-peer-urls $peer \
  --listen-client-urls $client \
  --advertise-client-urls $client \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster $cluster \
  --initial-cluster-state new 2> /etcd/mem/$me.log
