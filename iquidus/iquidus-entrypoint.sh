#!/bin/ash

sed \
  -e 's/IQ_COINRPCUSER/'${MAZAD_RPCUSER}'/g' \
  -e 's/IQ_COINRPCPASS/'${MAZAD_RPCPASS}'/g' \
  -e 's/IQ_TITLE/'${IQUIDUS_TITLE}'/g' \
  -e 's/IQ_PORT/'${IQUIDUS_PORT}'/g' \
  -e 's/IQ_MONGO_DB/'${MONGODB_DBNAME}'/g' \
  -e 's/IQ_MONGO_USER/'${MONGODB_USERNAME}'/g' \
  -e 's/IQ_MONGO_PASS/'${MONGODB_PASSWORD}'/g' \
  -e 's/IQ_MONGO_HOST/mongodb/g' \
  -i /app/explorer/settings.json

x=1
while true ; do sleep 5 ; ((x++)) ; echo $x ; done
#  "title": "IQ_TITLE",
#  "port" : IQ_PORT,
#    "user": "IQ_MONGO_USER",
#    "password": "IQ_MONGO_PASS",
#    "database": "IQ_MONGO_DB",
#    "address": "IQ_MONGO_HOST",
#    "user": "IQ_COINRPCUSER",
#    "pass": "IQ_COINRPCPASS"
