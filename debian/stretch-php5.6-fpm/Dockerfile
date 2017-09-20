FROM debian:stretch

MAINTAINER Gustavo Soares <gustavo@ontic.com.br>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://httpredir.debian.org/debian jessie main contrib non-free" >> /etc/apt/sources.list

COPY jessie /etc/apt/preferences.d/

COPY run.sh /run.sh

RUN apt-get update && \
    apt-get install lsof apt-utils -y && \
    apt-get install -t jessie php5-fpm php5-gd php5-json php5-mcrypt php5-mysql php5-readline php5-xmlrpc php5-cli -y

RUN apt-get clean && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/run.sh"] 
