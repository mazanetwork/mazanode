#!/bin/ash

### For now, we load settings.json after manual config
### this needs expansion/correction to enable the env vars

#sed \
#  -e 's/IQ_COINRPCUSER/'${MAZAD_RPCUSER}'/g' \
#  -e 's/IQ_COINRPCPASS/'${MAZAD_RPCPASS}'/g' \
#  -e 's/IQ_TITLE/'${IQUIDUS_TITLE}'/g' \
#  -e 's/IQ_PORT/'${IQUIDUS_PORT}'/g' \
#  -e 's/IQ_MONGO_DB/'${MONGODB_DBNAME}'/g' \
#  -e 's/IQ_MONGO_USER/'${MONGODB_USERNAME}'/g' \
#  -e 's/IQ_MONGO_PASS/'${MONGODB_PASSWORD}'/g' \
#  -e 's/IQ_MONGO_HOST/mongodb/g' \
#  -i /app/explorer/settings.json

run_update() {
 sleep 120
 while true ; do
   node --stack-size=10000 ./scripts/sync.js index update 
   sleep 60
 done
}
run_market() {
 sleep 130
 while true ; do
   node --stack-size=10000 ./scripts/sync.js market
   sleep 120
 done
}
run_peers() {
 sleep 140
 while true ; do
   node --stack-size=10000 ./scripts/sync.js index update 
   sleep 300
 done
}

cd /app
run_update &
run_market &
run_peers &
npm start
