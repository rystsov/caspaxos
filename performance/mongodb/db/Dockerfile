FROM ubuntu:17.10
LABEL maintainer="Denis Rystsov <rystsov.denis@gmail.com>"
RUN apt-get update -y
RUN apt-get install -y wget supervisor iptables gdb
RUN apt-get install -y iputils-ping vim tmux less curl
RUN /bin/bash -c "curl -sL https://deb.nodesource.com/setup_8.x | bash -"
RUN apt-get install -y nodejs
RUN mkdir -p /mongo
WORKDIR /mongo
RUN wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.6.1.tgz
RUN tar -xzvf mongodb-linux-x86_64-3.6.1.tgz
RUN rm mongodb-linux-x86_64-3.6.1.tgz
COPY run-mongo.sh /mongo/run-mongo.sh
COPY run-tester.sh /mongo/run-tester.sh
COPY topology /mongo/topology
COPY isolate.sh /mongo/isolate.sh
COPY rejoin.sh /mongo/rejoin.sh
COPY mongo.conf /etc/supervisor/conf.d/mongo.conf
COPY remote-tester /mongo/remote-tester
WORKDIR /mongo/remote-tester
RUN npm install
WORKDIR /mongo
CMD /usr/bin/supervisord -n