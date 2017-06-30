FROM debian:stretch-slim

MAINTAINER SLot <slotmg@protonmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y git make automake gcc screen libcurl4-openssl-dev build-essential 
RUN apt-get clean && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/OhGodAPet/cpuminer-multi /opt/cpuminer-multi
RUN cd /opt/cpuminer-multi ; ./autogen.sh ; CFLAGS="-march=native" ./configure --disable-aes-ni; make 
COPY docker-entrypoint.sh /
RUN chmod 777 /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
