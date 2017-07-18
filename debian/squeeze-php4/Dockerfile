FROM slotmg/squeeze

MAINTAINER Gustavo Soares <gustavo@ontic.com.br>

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL pt_BR

RUN echo "deb http://archive.debian.org/debian/ squeeze main contrib non-free" > /etc/apt/sources.list        && \
    echo "deb http://snapshot.debian.org/archive/debian/20070612T000000Z lenny main" >> /etc/apt/sources.list && \
    echo "locales locales/locales_to_be_generated multiselect pt_BR ISO-8859-1" | debconf-set-selections      && \
    echo "locales locales/default_environment_locale select pt_BR" | debconf-set-selections

RUN apt-get update                                     && \
    apt-get -y --no-install-recommends install locales && \
    apt-get -y --no-install-recommends --force-yes install apache2 libapache2-mod-php4 php4 php4-auth-pam php4-cli php4-common php4-curl php4-domxml php4-gd php4-imagick php4-json php4-librdf php4-mcal php4-mcrypt php4-mhash php4-pear php4-pgsql php4-ps php4-pspell php4-recode php4-uuid 

COPY run.sh /run.sh
COPY zend.tar.xz /zend.tar.xz
COPY default /etc/apache2/sites-available/default  

RUN chmod +x /run.sh && \
    tar Jxf /zend.tar.xz -C / 

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*                      && \
    rm -f /zend.tar.xz /etc/php4/cli/php.ini /etc/php4/apache2/php.ini && \
    ln -sf /usr/local/Zend/etc/php.ini /etc/php4/apache2/php.ini       && \
    ln -sf /usr/local/Zend/etc/php.ini /etc/php4/cli/php.ini           && \
    apt-get clean                                                      && \
    apt-get autoremove --purge -y                                      

CMD ["/run.sh"] 
