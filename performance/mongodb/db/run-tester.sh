#!/bin/bash

set -e

me=$(hostname)

mongo1=$(getent hosts mongo1 | awk '{ print $1 }')
mongo2=$(getent hosts mongo2 | awk '{ print $1 }')
mongo3=$(getent hosts mongo3 | awk '{ print $1 }')

if [ -z "$mongo1" ] ; then exit 1 ; fi;
if [ -z "$mongo2" ] ; then exit 1 ; fi;
if [ -z "$mongo3" ] ; then exit 1 ; fi;

/mongo/mongodb-linux-x86_64-3.6.1/bin/mongo --host mongo1 < /mongo/topology

nodejs /mongo/remote-tester/src/start.js > /mongo/mem/$me.tester.log
