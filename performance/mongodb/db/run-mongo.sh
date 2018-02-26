#!/bin/bash

set -e

me=$(hostname)

node1=$(getent hosts node1 | awk '{ print $1 }')
node2=$(getent hosts node2 | awk '{ print $1 }')
node3=$(getent hosts node3 | awk '{ print $1 }')

if [ -z "$node1" ] ; then exit 1 ; fi;
if [ -z "$node2" ] ; then exit 1 ; fi;
if [ -z "$node3" ] ; then exit 1 ; fi;

/mongo/mongodb-linux-x86_64-3.6.1/bin/mongod --dbpath /mongo/mem --replSet rs0 --port 27017 --bind_ip 0.0.0.0 >> /mongo/mem/$me.log