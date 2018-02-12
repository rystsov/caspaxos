#!/bin/bash

date | tee /etcd/logs/client1.log
nodejs app/src/test.js $@ 2>&1 | tee -a /etcd/logs/client1.log
