#!/bin/ash

chown -R mongodb /data

# Initialize first run
if [[ ! -e /data/.first-run-completed ]]; then
   su -c '/app/first_run.sh' -s /bin/ash mongodb
fi

# Start MongoDB
echo "Starting MongoDB..."
#su -c '/usr/bin/mongod --config /etc/mongod.conf --auth $@' -s /bin/ash mongodb
su -c '/usr/bin/mongod --storageEngine inMemory --dbpath /data
#su -c '/usr/bin/mongod --dbpath /data --auth $@' -s /bin/ash mongodb
