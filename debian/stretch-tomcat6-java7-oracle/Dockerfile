FROM debian:stretch

MAINTAINER Gustavo Soares <gustavo@ontic.com.br>


ENV DEBIAN_FRONTEND noninteractive
RUN echo "locales locales/locales_to_be_generated multiselect pt_BR ISO-8859-1" | debconf-set-selections &&\
    echo "locales locales/default_environment_locale select pt_BR" | debconf-set-selections
ENV LC_ALL pt_BR

# Preparando repositorios
RUN echo "deb http://sft.if.usp.br/debian/ wheezy main contrib non-free" >> /etc/apt/sources.list
COPY wheezy /etc/apt/preferences.d/
COPY oracle-java7-jre_7u80_amd64.deb /tmp/
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Instalando pacotes.
RUN apt-get update && \
    apt-get install --no-install-recommends locales lsof apt-utils libpangoft2-1.0-0 libcairo2 libgdk-pixbuf2.0-0 \
            libatk1.0-0 libgtk2.0-0 libxxf86vm1 libgl1-mesa-glx libxslt1.1 procps -y && \
    apt-get install --no-install-recommends -t wheezy tomcat6 tomcat6-user tomcat6-admin tomcat6-common -y

RUN dpkg -i /tmp/oracle-java7-jre_7u80_amd64.deb

# Configurando java/tomcat
RUN update-alternatives --install /usr/bin/java java  /usr/lib/jvm/jre-7-oracle-x64/bin/java 4 ; \
    update-alternatives --set java /usr/lib/jvm/jre-7-oracle-x64/bin/java

# Tomcat6
RUN /etc/init.d/tomcat6 stop
COPY tomcat6 /etc/default/tomcat6 
COPY tomcat6-start /etc/init.d/tomcat6
RUN chgrp tomcat6 /etc/tomcat6/*

# Limpando
RUN apt-get clean && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/run.sh"]
