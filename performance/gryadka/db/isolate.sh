#!/bin/bash

set -e

gryadka1=$(getent hosts gryadka1 | awk '{ print $1 }')
gryadka2=$(getent hosts gryadka2 | awk '{ print $1 }')
gryadka3=$(getent hosts gryadka3 | awk '{ print $1 }')

myip=$(getent hosts $(hostname) | awk '{ print $1 }')

if [ -z "$gryadka1" ] ; then exit 1 ; fi;
if [ -z "$gryadka2" ] ; then exit 1 ; fi;
if [ -z "$gryadka3" ] ; then exit 1 ; fi;

python -c "for ip in (set(['$gryadka1', '$gryadka2', '$gryadka3']) - set(['$myip'])): print ip" | xargs -I '{}' echo "Isolating: {}"

python -c "for ip in (set(['$gryadka1', '$gryadka2', '$gryadka3']) - set(['$myip'])): print ip" | xargs -I '{}' iptables -A INPUT -s '{}' -j DROP
python -c "for ip in (set(['$gryadka1', '$gryadka2', '$gryadka3']) - set(['$myip'])): print ip" | xargs -I '{}' iptables -A OUTPUT -d '{}' -j DROP

echo "Isolated"