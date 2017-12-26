#!/bin/sh

docker-compose up -d ipfs
docker-compose exec ipfs 'ipfs pin add -r --progress QmWsmEE9PL9rTiJtdayp8cfQoMcMqhgwxZodqtPa6A5NM9'
docker-compose exec ipfs 'ipfs get -o /data/tarballs QmWsmEE9PL9rTiJtdayp8cfQoMcMqhgwxZodqtPa6A5NM9'
