ARG NGINX_VERSION="1.18.0"

FROM nginx:${NGINX_VERSION}-alpine as build_modsecurity
LABEL maintainer="SLot <slotmg@protonmail.com>"
ARG MODSEC_BRANCH=v3.0.4
ARG GEO_DB_RELEASE=2020-04
ARG OWASP_BRANCH=v3.2/master
WORKDIR /opt

RUN \
    echo "=> Instalando base" && \
    apk add --no-cache --virtual general-dependencies autoconf automake byacc curl-dev flex g++ gcc geoip-dev git libc-dev libmaxminddb-dev libstdc++ libtool libxml2-dev linux-headers lmdb-dev make openssl-dev pcre-dev wget yajl-dev zlib-dev 

RUN \
    echo "=> MODSEC" && \
    git clone -b ${MODSEC_BRANCH} --depth 1 https://github.com/SpiderLabs/ModSecurity && \
    git -C /opt/ModSecurity submodule update --init --recursive && \
    (cd "/opt/ModSecurity" && ./build.sh && ./configure --with-lmdb && make && make install ) && \
    rm -fr /opt/ModSecurity /usr/local/modsecurity/lib/libmodsecurity.a /usr/local/modsecurity/lib/libmodsecurity.la

RUN \
    echo "=> MODSEC-NGINX GEOIP OWASP" && \
    git clone -b master --depth 1 https://github.com/SpiderLabs/ModSecurity-nginx.git && \
    git clone -b master --depth 1 https://github.com/leev/ngx_http_geoip2_module.git && \
    git clone -b ${OWASP_BRANCH} --depth 1 https://github.com/SpiderLabs/owasp-modsecurity-crs /usr/local/owasp-modsecurity-crs && \
    wget -O - https://nginx.org/download/nginx-$NGINX_VERSION.tar.gz | tar -xz && \
    mkdir -p /etc/nginx/geoip && \
    wget -O - https://download.db-ip.com/free/dbip-city-lite-${GEO_DB_RELEASE}.mmdb.gz | gzip -d > /etc/nginx/geoip/dbip-city-lite.mmdb && \
    wget -O - https://download.db-ip.com/free/dbip-country-lite-${GEO_DB_RELEASE}.mmdb.gz | gzip -d > /etc/nginx/geoip/dbip-country-lite.mmdb

RUN \
    echo "=> NGINX-MODULES" && \
    (cd "/opt/nginx-$NGINX_VERSION" && ./configure --with-compat --add-dynamic-module=../ModSecurity-nginx --add-dynamic-module=../ngx_http_geoip2_module && make modules ) && \
    cp /opt/nginx-$NGINX_VERSION/objs/ngx_http_modsecurity_module.so /opt/nginx-$NGINX_VERSION/objs/ngx_http_geoip2_module.so /usr/lib/nginx/modules/ && \
    rm -fr /opt/* && \
    apk del general-dependencies


FROM nginx:${NGINX_VERSION}-alpine
LABEL maintainer="SLot <slotmg@protonmail.com>"

COPY --from=build_modsecurity /etc/nginx/ /etc/nginx/
COPY --from=build_modsecurity /usr/local/modsecurity /usr/local/modsecurity
COPY --from=build_modsecurity /usr/local/owasp-modsecurity-crs /usr/local/owasp-modsecurity-crs
COPY --from=build_modsecurity /usr/lib/nginx/modules/ /usr/lib/nginx/modules/

COPY errors /usr/share/nginx/errors
COPY conf/nginx/ /etc/nginx/
COPY conf/modsec/ /etc/nginx/modsec/
COPY conf/owasp/ /usr/local/owasp-modsecurity-crs/

RUN \ 
    echo "=> Instalando BASE" && \
    apk add --no-cache curl-dev libmaxminddb-dev libstdc++ libxml2-dev lmdb-dev tzdata yajl && \
    chown -R nginx:nginx /usr/share/nginx

WORKDIR /usr/share/nginx/html

EXPOSE 80 443

