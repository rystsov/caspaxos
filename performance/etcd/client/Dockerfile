FROM ubuntu:17.10
LABEL maintainer="Denis Rystsov <rystsov.denis@gmail.com>"
RUN apt-get update -y
RUN apt-get install -y iputils-ping vim tmux less curl
RUN /bin/bash -c "curl -sL https://deb.nodesource.com/setup_8.x | bash -"
RUN apt-get install -y nodejs
RUN mkdir -p /etcd
WORKDIR /etcd
COPY test.sh /etcd/test.sh
COPY app /etcd/app
WORKDIR /etcd/app
RUN npm install
WORKDIR /etcd
CMD /etcd/test.sh
