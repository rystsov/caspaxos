#!/bin/bash

set -e

if ! docker images | grep caspaxos_pdflatex; then
  docker build -t="caspaxos_pdflatex" .
fi

docker run -i -t --name=caspaxos_pdflatex \
  -v $(pwd)/latex:/latex \
  caspaxos_pdflatex
  
docker rm caspaxos_pdflatex