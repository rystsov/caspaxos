#!/bin/bash

date | tee /client/logs/client1.log
nodejs app/src/test.js $@ 2>&1 | tee -a /client/logs/client1.log
