FROM ubuntu:17.10
LABEL maintainer="Denis Rystsov <rystsov.denis@gmail.com>"
RUN apt-get update -y
RUN apt-get install -y iputils-ping vim tmux less curl
RUN /bin/bash -c "curl -sL https://deb.nodesource.com/setup_8.x | bash -"
RUN apt-get install -y nodejs
RUN mkdir -p /client
WORKDIR /client
COPY test.sh /client/test.sh
COPY app /client/app
WORKDIR /client/app
RUN npm install
WORKDIR /client
CMD /client/test.sh
