#!/bin/bash

apt-get update -y
apt-get install -y git
apt-get install -y wget supervisor iptables iputils-ping vim tmux less
git clone https://github.com/rystsov/caspaxos.git
