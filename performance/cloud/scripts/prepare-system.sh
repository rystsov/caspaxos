#!/bin/bash

apt-get update -y
apt-get install -y git wget supervisor iptables iputils-ping vim tmux less hping3 curl
git clone https://github.com/rystsov/caspaxos.git
