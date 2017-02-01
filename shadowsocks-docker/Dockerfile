# Shadowsocks Server Dockerfile

FROM alpine

ENV SS_VER 2.6.3
ENV SS_URL https://github.com/shadowsocks/shadowsocks-libev/archive/v$SS_VER.tar.gz
ENV SS_DIR shadowsocks-libev-$SS_VER

RUN set -ex \
    && apk add --no-cache libcrypto1.0 \
                          libev \
                          libsodium \
                          pcre \
                          udns \
    && apk add --no-cache \
               --virtual TMP autoconf \
                             automake \
                             build-base \
                             curl \
                             gettext-dev \
                             libev-dev \
                             libsodium-dev \
                             libtool \
                             linux-headers \
                             openssl-dev \
                             pcre-dev \
                             tar \
                             udns-dev \
    && curl -sSL $SS_URL | tar xz \
    && cd $SS_DIR \
        && curl -sSL https://github.com/shadowsocks/ipset/archive/shadowsocks.tar.gz | tar xz --strip 1 -C libipset \
        && curl -sSL https://github.com/shadowsocks/libcork/archive/shadowsocks.tar.gz | tar xz --strip 1 -C libcork \
        && ./autogen.sh \
        && ./configure --disable-documentation \
        && make install \
        && cd .. \
        && rm -rf $SS_DIR \
    && apk del TMP

ENV SS_PORT=443
ENV SS_PASSWORD=123456
ENV SS_METHOD=chacha20
ENV SS_TIMEOUT=600
ENV SS_DNS1=8.8.8.8
ENV SS_DNS2=8.8.4.4

EXPOSE $SS_PORT/tcp $SS_PORT/udp

ENTRYPOINT ss-server -p $SS_PORT -k $SS_PASSWORD -m $SS_METHOD -t $SS_TIMEOUT -d $SS_DNS1 -d $SS_DNS2 -u --fast-open

