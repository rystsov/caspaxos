#!/bin/bash

docker rm caspaxos
docker build -t="caspaxos_pdflatex" .
docker create -t --name=caspaxos -v $(pwd)/latex:/latex caspaxos_pdflatex