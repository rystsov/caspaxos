FROM ubuntu:17.10
LABEL maintainer="Denis Rystsov <rystsov.denis@gmail.com>"
RUN apt-get update -y
RUN apt-get install -y iputils-ping vim tmux less curl
RUN /bin/bash -c "curl -sL https://deb.nodesource.com/setup_8.x | bash -"
RUN apt-get install -y nodejs
RUN mkdir -p /mongo
WORKDIR /mongo
COPY test.sh /mongo/test.sh
COPY app /mongo/app
WORKDIR /mongo/app
RUN npm install
WORKDIR /mongo
CMD /mongo/test.sh
