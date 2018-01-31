FROM ubuntu:17.10
LABEL maintainer="Denis Rystsov <rystsov.denis@gmail.com>"
RUN apt-get update -y
RUN apt-get install -y texlive-xetex ttf-liberation fonts-liberation
CMD /latex/buildpdf.sh
