#!/bin/bash

docker rm client1
mkdir -p $(pwd)/logs
docker run -i -t --name=client1 --hostname=client1 --network=perseus -v $(pwd)/logs:/client/logs perseus_client