#!/bin/sh -x

# Mazacoind is expected to be at hostname 'mazacoind'
# which is set via --link
# Because we use linked containers we can use the 
# standard ports 
### Tate-server doesn't really support testnet
. /app/tateserver.env
#USER=${USER:-maza}
#TATE_HOSTNAME=${TATE_HOSTNAME:-${HOSTNAME}}
#TATE_PORT=${TATE_PORT:-50001}
#TATE_SSLPORT=${TATE_SSL_PORT:-50002}
#MAZACOIND=${MAZACOIND:-mazad}
#MAZADIR=${MAZADIR:-/home/${USER}/.maza}
#RPCPORT=${RPCPORT:-12832}
#RPCUSER=${RPCUSER:-$(grep rpcuser "${MAZADIR}"/maza.conf |awk -F= '{print $2}')}
RPCPASSWORD=${RPCPASSWORD:-$(grep rpcpassword "${MAZADIR}"/maza.conf |awk -F= '{print $2}')}
#TXINDEX=$(grep "txindex=" "${MAZADIR}"/maza.conf |awk -F= '{print $2}')


TATE_PASSWORD=$(egrep '^password =' /etc/tate.conf|awk -F= '{print $2}')

TATE_PASSWORD=$(apg -a 0 -m 32 -x 32 -n 1)
if [ "${TXINDEX}" = "1" ] ; then
   echo "-txindex is set    good to go"
else echo "$(date) txindex not set in mazacoin.conf - daemon restart required"
     touch /etc/service/mazacoind/down
     echo "Now you can start mazacoind manually with -reindex and then add:"
     echo "txindex=1"
     echo "to your ${MAZADIR}/mazacoin.conf"
     echo "then remove /etc/service/mazacoind/down"
fi     
## this is kinda backwards, but there you have it
echo "$(date) starting tate-server with RPC from: ${MAZACOIND}:${RPCPORT}"
cd /app
IFS="" sed -i	-e 's/bitcoind_host\ \=.*/bitcoind_host\ \=\ '${MAZACOIND}'/g' \
	-e 's/bitcoind_port\ \=.*/bitcoind_port\ \=\ '${RPCPORT}'/g' \
	-e 's/bitcoind_user\ \=.*/bitcoind_user\ \=\ '${RPCUSER}'/g' \
	-e 's/bitcoind_password\ \=.*/bitcoind_password\ \=\ '${RPCPASSWORD}'/g' \
	-e 's/^host\ \=.*/host\ \=\ '${TATE_HOSTNAME}'/g' \
	-e 's/^password\ \=.*/password\ \=\ '${TATE_PASSWORD}'/g' \
	-e 's/^username\ \=.*/username\ \=\ '${USER}'/g' \
	-e 's/^stratum_tcp_ssl_port\ \=.*/stratum_tcp_ssl_port\ \=\ '${TATE_SSLPORT}'/g' \
	-e 's/^stratum_tcp_port\ \=.*/stratum_tcp_port\ \=\ '${TATE_PORT}'/g' \
	tate.conf
cp tate.conf /etc/tate.conf
exec su -c '/app/run_tate_server' -s /bin/ash ${USER}
