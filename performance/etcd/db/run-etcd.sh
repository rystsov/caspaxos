#!/bin/bash

me=$(hostname)

node1=$(getent hosts node1 | awk '{ print $1 }')
node2=$(getent hosts node2 | awk '{ print $1 }')
node3=$(getent hosts node3 | awk '{ print $1 }')

if [ -z "$node1" ] ; then exit 1 ; fi;
if [ -z "$node2" ] ; then exit 1 ; fi;
if [ -z "$node3" ] ; then exit 1 ; fi;

myip=$(getent hosts $me | awk '{ print $1 }')

cluster="node1=http://$node1:2380,node2=http://$node2:2380,node3=http://$node3:2380"
peer="http://$myip:2380"
client="http://$myip:2379"

/etcd/etcd-v3.2.13-linux-amd64/etcd \
  --heartbeat-interval=200 \
  --election-timeout=2000 \
  --data-dir "/etcd/mem/$me" \
  --name $me \
  --initial-advertise-peer-urls $peer \
  --listen-peer-urls "http://0.0.0.0:2380" \
  --listen-client-urls "http://0.0.0.0:2379" \
  --advertise-client-urls $client \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster $cluster \
  --initial-cluster-state new 2> /etcd/mem/$me.log
