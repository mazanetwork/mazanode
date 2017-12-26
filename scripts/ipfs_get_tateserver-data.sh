#!/bin/sh


docker-compose up -d ipfs
docker-compose exec ipfs 'ipfs pin add -r QmPTKspzV6mNXyFpg2uQ5AnLn53XHyQ9N5WbHf92jjeUVC'
docker-compose exec ipfs 'ipfs get -o /data/tarballs QmPTKspzV6mNXyFpg2uQ5AnLn53XHyQ9N5WbHf92jjeUVC/mazanodes/databases/tate-server_20171224.tbz2'

