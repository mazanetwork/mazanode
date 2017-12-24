FROM alpine:3.6

MAINTAINER Rui Marinho <ruipmarinho@gmail.com> (@ruimarinho)

RUN adduser -S bitcoin

ENV BERKELEYDB_VERSION=db-4.8.30.NC
ENV BERKELEYDB_PREFIX=/opt/${BERKELEYDB_VERSION}

ENV BITCOIN_VERSION=0.14.2
ENV BITCOIN_PREFIX=/opt/bitcoin-${BITCOIN_VERSION}
ENV BITCOIN_DATA=/home/bitcoin/.bitcoin
ENV PATH=${BITCOIN_PREFIX}/bin:$PATH

RUN apk --no-cache --virtual build-dependendencies add autoconf \
    automake \
    boost-dev \
    build-base \
    chrpath \
    file \
    gnupg \
    libevent-dev \
    libressl \
    libressl-dev \
    libtool \
    linux-headers \
    protobuf-dev \
    zeromq-dev 
RUN echo BerkeleyDB \
  && mkdir -p /tmp/build \
  && mkdir -p /tmp/build/${BITCOIN_VERSION} \
  && wget -O /tmp/build/${BERKELEYDB_VERSION}.tar.gz http://download.oracle.com/berkeley-db/${BERKELEYDB_VERSION}.tar.gz \
  && tar -xzf /tmp/build/${BERKELEYDB_VERSION}.tar.gz -C /tmp/build/ \
  && sed s/__atomic_compare_exchange/__atomic_compare_exchange_db/g -i /tmp/build/${BERKELEYDB_VERSION}/dbinc/atomic.h \
  && mkdir -p ${BERKELEYDB_PREFIX} \
  && cd /tmp/build/${BERKELEYDB_VERSION}/build_unix \
  && ../dist/configure --enable-cxx --disable-shared --with-pic --prefix=${BERKELEYDB_PREFIX} \
  && make install 

