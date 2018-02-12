#!/bin/bash

set -e

redis-cli -h 127.0.0.1 -p 6379 SCRIPT LOAD "$(cat /gryadka/remote-tester/node_modules/gryadka/src/lua/accept.lua)" > /gryadka/accept.hash
redis-cli -h 127.0.0.1 -p 6379 SCRIPT LOAD "$(cat /gryadka/remote-tester/node_modules/gryadka/src/lua/prepare.lua)" > /gryadka/prepare.hash

me=$(hostname)

nodejs /gryadka/remote-tester/src/start.js "/gryadka/cluster.json" $me > /gryadka/mem/$me.api.log
