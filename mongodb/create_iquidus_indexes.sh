sh -c 'mongo iquidus -u iquidus -p 123dontgetme --eval  "db.addresses.createIndex( { a_id : 1})"' -s /bin/ash mongodb
sh -c 'mongo iquidus -u iquidus -p 123dontgetme --eval  "db.txes.createIndex( { txid : 1})"' -s /bin/ash mongodb

 sh -c 'mongo iquidus -u iquidus -p 123dontgetme --eval  "db.txes.createIndex({timestamp: -1})"'  -s /bin/ash mongodb
