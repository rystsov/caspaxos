#!/bin/bash

set -e

node1=$(getent hosts node1 | awk '{ print $1 }')
node2=$(getent hosts node2 | awk '{ print $1 }')
node3=$(getent hosts node3 | awk '{ print $1 }')

myip=$(getent hosts $(hostname) | awk '{ print $1 }')

if [ -z "$node1" ] ; then exit 1 ; fi;
if [ -z "$node2" ] ; then exit 1 ; fi;
if [ -z "$node3" ] ; then exit 1 ; fi;

python -c "for ip in (set(['$node1', '$node2', '$node3']) - set(['$myip'])): print ip" | xargs -I '{}' echo "Rejoining: {}"

python -c "for ip in (set(['$node1', '$node2', '$node3']) - set(['$myip'])): print ip" | xargs -I '{}' iptables -D INPUT -s '{}' -j DROP
python -c "for ip in (set(['$node1', '$node2', '$node3']) - set(['$myip'])): print ip" | xargs -I '{}' iptables -D OUTPUT -d '{}' -j DROP

echo "Rejoined"