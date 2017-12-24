FROM maza/mazanode-coind:openssl-base  as mazabuilder

ENV BITCOIN_VERSION=0.10.2
ENV BITCOIN_PREFIX=/opt/maza-${BITCOIN_VERSION}
ENV BITCOIN_DATA=/home/maza/.maza
ENV PATH=${BITCOIN_PREFIX}/bin:$PATH


#RUN echo Get_Bitcoin_Source \
#  && gpg --keyserver pgp.mit.edu  --recv-keys 93AEC55F \
#  && mkdir /tmp/build/${BITCOIN_VERSION} \
#  && wget -P /tmp/build/${BITCOIN_VERSION} https://ipfs.guruvan.net/ipfs/QmeFphaDUMjMhqih5w54g5mvqKzNMibPJJ8DNehhWtaVME/SHA256SUMS.sig \
#  && wget -P /tmp/build/${BITCOIN_VERSION} https://ipfs.guruvan.net/ipfs/QmeFphaDUMjMhqih5w54g5mvqKzNMibPJJ8DNehhWtaVME/SHA256SUMS \
#  && wget -P /tmp/build/${BITCOIN_VERSION} https://ipfs.io/ipfs/QmeFphaDUMjMhqih5w54g5mvqKzNMibPJJ8DNehhWtaVME/src/maza-${BITCOIN_VERSION}.tar.gz \
#  && gpg --verify /tmp/build/${BITCOIN_VERSION}/SHA256SUMS.sig \
#  && cd /tmp/build/${BITCOIN_VERSION} \
#  && grep "maza-${BITCOIN_VERSION}.tar.gz\$" /tmp/build/${BITCOIN_VERSION}/SHA256SUMS | sha256sum -c - \
#  && tar -xzf maza-${BITCOIN_VERSION}.tar.gz -C /tmp/build 
RUN apk --no-cache add git \
  && git clone https://github.com/mazacoin/maza /tmp/build/${BITCOIN_VERSION}

RUN echo Configure_Compile_Bitcoind \
  && cd /tmp/build/${BITCOIN_VERSION} \
  && git checkout v${BITCOIN_VERSION} \
  && ls -la \
  && ./autogen.sh \
  && ./configure LDFLAGS=-L${BERKELEYDB_PREFIX}/lib/ CPPFLAGS=-I${BERKELEYDB_PREFIX}/include/ \
    --prefix=${BITCOIN_PREFIX} \
    --mandir=/usr/share/man \
    --disable-tests \
    --disable-bench \
    --disable-ccache \
    --with-gui=no \
    --with-utils \
    --with-libs \
    --with-daemon 
RUN echo "Compile_Bitcoind" \
  && cd /tmp/build/${BITCOIN_VERSION} \
  && make -j3 install \
  && cd / \
  && strip ${BITCOIN_PREFIX}/bin/maza-cli ${BITCOIN_PREFIX}/bin/mazad ${BITCOIN_PREFIX}/bin/maza-tx ${BITCOIN_PREFIX}/lib/libmazaconsensus.a ${BITCOIN_PREFIX}/lib/libmazaconsensus.so.0.0.0 

RUN echo Clean_up_Build \
  && rm -rf /tmp/build ${BERKELEYDB_PREFIX}/docs \
  && apk --no-cache --purge del build-dependendencies \
  &&  echo done Clean_up_Build

FROM alpine:3.2
  
RUN echo Install_RunDeps \
  && apk --no-cache add boost \
    boost-program_options \
    libevent \
    openssl \
    libzmq \
    su-exec

RUN adduser -S -u 1000 maza

ENV BITCOIN_VERSION=0.10.2
ENV BITCOIN_PREFIX=/opt/maza-${BITCOIN_VERSION}
ENV BITCOIN_DATA=/home/maza/.maza
ENV PATH=${BITCOIN_PREFIX}/bin:$PATH
COPY --from=mazabuilder /opt/maza-0.10.2/ /opt/maza-0.10.2/


VOLUME ["/home/maza/.maza"]

COPY docker-entrypoint-maza.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 12832 12835


CMD ["mazad"]
