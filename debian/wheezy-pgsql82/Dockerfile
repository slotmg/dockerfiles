FROM slotmg/wheezy

MAINTAINER Gustavo Soares <gustavo@ontic.com.br>

ENV PG_MAJOR 8.2
ENV PG_VERSION 8.2.23-1.pgdg70+1
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL pt_BR
ENV LANG=pt_BR

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list &&\
    apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 &&\
    apt-get update &&\
    apt-get -y install --no-install-recommends postgresql-$PG_MAJOR=$PG_VERSION postgresql-contrib-$PG_MAJOR=$PG_VERSION postgresql-client-$PG_MAJOR=$PG_VERSION postgresql-common

RUN apt-get clean &&\
    apt-get autoremove --purge -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY pg_hba.conf /etc/postgresql/8.2/main/pg_hba.conf
COPY postgresql.conf /etc/postgresql/8.2/main/postgresql.conf
RUN chown postgres: /etc/postgresql/8.2/main/*.conf


EXPOSE 5432
#VOLUME  ["/etc/postgresql/8.2", "/var/log/postgresql", "/var/lib/postgresql/8.2"]
VOLUME  ["/var/log/postgresql/", "/var/lib/postgresql/8.2/"]

USER postgres
CMD ["/usr/lib/postgresql/8.2/bin/postgres", "-D", "/var/lib/postgresql/8.2/main", "-c", "config_file=/etc/postgresql/8.2/main/postgresql.conf"]


