#
# Dockerfile for shadowsocks-libev
#

FROM alpine
MAINTAINER kev <noreply@datageek.info>

ARG SS_VER=3.0.0
ARG SS_URL=https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$SS_VER/shadowsocks-libev-$SS_VER.tar.gz

ENV SERVER_ADDR 0.0.0.0
ENV SS_PORT=443
ENV SS_PASSWORD=
ENV SS_METHOD=chacha20
ENV SS_TIMEOUT=300
ENV SS_DNS1=8.8.8.8
ENV SS_DNS2=8.8.4.4

RUN set -ex && \
    apk add --no-cache --virtual .build-deps \
                                autoconf \
                                build-base \
                                curl \
                                libev-dev \
                                libtool \
                                linux-headers \
                                udns-dev \
                                libsodium-dev \
                                mbedtls-dev \
                                pcre-dev \
                                tar \
                                udns-dev && \
    cd /tmp && \
    curl -sSL $SS_URL | tar xz --strip 1 && \
    ./configure --prefix=/usr --disable-documentation && \
    make install && \
    cd .. && \

    runDeps="$( \
        scanelf --needed --nobanner /usr/bin/ss-* \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | xargs -r apk info --installed \
            | sort -u \
    )" && \
    apk add --no-cache --virtual .run-deps $runDeps && \
    apk del .build-deps && \
    rm -rf /tmp/*

USER nobody

EXPOSE $SS_PORT/tcp $SS_PORT/udp

CMD ss-server -s $SERVER_ADDR \
              -p $SS_PORT \
              -k ${SS_PASSWORD:-$(hostname)} \
              -m $SS_METHOD \
              -t $SS_TIMEOUT \
              --fast-open \
              -d $SS_DNS1 \
              -d $SS_DNS2 \
              -u
