FROM debian:squeeze

MAINTAINER Gustavo Soares <gustavo@ontic.com.br>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://archive.debian.org/debian/ squeeze main contrib non-free" > /etc/apt/sources.list
RUN apt-get update

RUN echo "locales locales/locales_to_be_generated multiselect pt_BR ISO-8859-1" | debconf-set-selections &&\
    echo "locales locales/default_environment_locale select pt_BR" | debconf-set-selections
RUN apt-get -y install --no-install-recommends locales 

RUN apt-get clean && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

