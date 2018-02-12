#!/bin/bash

set -e

me=$(hostname)

etcd1=$(getent hosts etcd1 | awk '{ print $1 }')
etcd2=$(getent hosts etcd2 | awk '{ print $1 }')
etcd3=$(getent hosts etcd3 | awk '{ print $1 }')

if [ -z "$etcd1" ] ; then exit 1 ; fi;
if [ -z "$etcd2" ] ; then exit 1 ; fi;
if [ -z "$etcd3" ] ; then exit 1 ; fi;

/etcd/remote-tester/bin/remote "http://$me:2379"
