#!/bin/bash

echo "# isolating $1" >> logs/client1.log
docker exec $1 /etcd/isolate.sh
echo "# isolated $1" >> logs/client1.log
