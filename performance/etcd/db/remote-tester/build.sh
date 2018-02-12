#!/bin/bash

set -e

export PATH=$PATH:/usr/lib/go-1.9/bin
export GOPATH=/etcd/remote-tester

cd /etcd/remote-tester/src/remote
go get
go build
go install
