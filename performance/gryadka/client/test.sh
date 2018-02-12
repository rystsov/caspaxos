#!/bin/bash

date | tee /gryadka/logs/client1.log
nodejs app/src/test.js $@ 2>&1 | tee -a /gryadka/logs/client1.log
