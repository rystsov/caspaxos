#!/bin/bash

set -e

etcd1=$(getent hosts etcd1 | awk '{ print $1 }')
etcd2=$(getent hosts etcd2 | awk '{ print $1 }')
etcd3=$(getent hosts etcd3 | awk '{ print $1 }')

myip=$(getent hosts $(hostname) | awk '{ print $1 }')

if [ -z "$etcd1" ] ; then exit 1 ; fi;
if [ -z "$etcd2" ] ; then exit 1 ; fi;
if [ -z "$etcd3" ] ; then exit 1 ; fi;

python -c "for ip in (set(['$etcd1', '$etcd2', '$etcd3']) - set(['$myip'])): print ip" | xargs -I '{}' echo "Rejoining: {}"

python -c "for ip in (set(['$etcd1', '$etcd2', '$etcd3']) - set(['$myip'])): print ip" | xargs -I '{}' iptables -D INPUT -s '{}' -j DROP
python -c "for ip in (set(['$etcd1', '$etcd2', '$etcd3']) - set(['$myip'])): print ip" | xargs -I '{}' iptables -D OUTPUT -d '{}' -j DROP

echo "Rejoined"