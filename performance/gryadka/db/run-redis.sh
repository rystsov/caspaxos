#!/bin/bash

me=$(hostname)

redis-server /gryadka/redis.conf > /gryadka/mem/$me.redis.log
