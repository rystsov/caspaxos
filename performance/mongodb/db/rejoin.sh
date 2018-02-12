#!/bin/bash

set -e

mongo1=$(getent hosts mongo1 | awk '{ print $1 }')
mongo2=$(getent hosts mongo2 | awk '{ print $1 }')
mongo3=$(getent hosts mongo3 | awk '{ print $1 }')

myip=$(getent hosts $(hostname) | awk '{ print $1 }')

if [ -z "$mongo1" ] ; then exit 1 ; fi;
if [ -z "$mongo2" ] ; then exit 1 ; fi;
if [ -z "$mongo3" ] ; then exit 1 ; fi;

python -c "for ip in (set(['$mongo1', '$mongo2', '$mongo3']) - set(['$myip'])): print ip" | xargs -I '{}' echo "Rejoining: {}"

python -c "for ip in (set(['$mongo1', '$mongo2', '$mongo3']) - set(['$myip'])): print ip" | xargs -I '{}' iptables -D INPUT -s '{}' -j DROP
python -c "for ip in (set(['$mongo1', '$mongo2', '$mongo3']) - set(['$myip'])): print ip" | xargs -I '{}' iptables -D OUTPUT -d '{}' -j DROP

echo "Rejoined"