#!/bin/bash

docker rm client1
mkdir -p $(pwd)/$1
docker run -i -t --name=client1 --hostname=client1 --network=perseus -v $(pwd)/$1:/client/logs perseus_client