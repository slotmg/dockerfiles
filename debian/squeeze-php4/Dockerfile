FROM debian:squeeze

MAINTAINER Gustavo Soares <gustavo@ontic.com.br>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://archive.debian.org/debian/ squeeze main contrib non-free" > /etc/apt/sources.list
RUN apt-get update

RUN echo "locales locales/locales_to_be_generated multiselect pt_BR ISO-8859-1" | debconf-set-selections &&\
    echo "locales locales/default_environment_locale select pt_BR" | debconf-set-selections
RUN apt-get -y install --no-install-recommends locales 

ENV LC_ALL pt_BR

RUN apt-get -y install apache2 libapache2-mod-php4 php4-pgsql php4-cli php4-curl php4-cgi php4-gd php4-imagick php4-mcal php4-mcrypt php4-mhash

RUN apt-get clean && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

