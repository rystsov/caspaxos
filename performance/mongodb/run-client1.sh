#!/bin/bash

docker rm client1
mkdir -p $(pwd)/logs
docker run -i -t --name=client1 --hostname=client1 --network=mongodb_perseus -v $(pwd)/logs:/mongo/logs mongo_client