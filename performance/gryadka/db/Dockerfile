FROM ubuntu:17.10
LABEL maintainer="Denis Rystsov <rystsov.denis@gmail.com>"
RUN apt-get update -y
RUN apt-get install -y wget supervisor iptables
RUN apt-get install -y iputils-ping vim tmux less curl
RUN apt-get install -y redis-server
RUN /bin/bash -c "curl -sL https://deb.nodesource.com/setup_8.x | bash -"
RUN apt-get install -y nodejs
RUN mkdir -p /gryadka
WORKDIR /gryadka
COPY isolate.sh /gryadka/isolate.sh
COPY rejoin.sh /gryadka/rejoin.sh
COPY redis.conf /gryadka/redis.conf
COPY run-redis.sh /gryadka/run-redis.sh
COPY remote-tester /gryadka/remote-tester
WORKDIR /gryadka/remote-tester
RUN npm install
WORKDIR /gryadka
COPY cluster.json /gryadka/cluster.json
COPY run-gryadka.sh /gryadka/run-gryadka.sh
COPY gryadka.conf /etc/supervisor/conf.d/gryadka.conf
CMD /usr/bin/supervisord -n
