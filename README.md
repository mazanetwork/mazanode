# mazanode

Multiapllication mazanode - service nodes for the MAZA Network

## Quickstart

git clone this repo
cd into it
 ```
 # install docker-enter
 docker run -it --rm -v /root/bin:/target jpetazzo/nsenter && docker rmi jpetazzo/nsenter
 # start all services
 docker-compose up -d
 ```

In practice, not quite so simple. 

You'll want a few things first

The explorer database and data for electruMAZA (Tate) 
take a long time to build, it's recommended to acquire the 
data via IPFS 

A public hostname in some domain is required to provide webservices
A public IP address is required for electruMAZA service and IPFS
You may need to forward ports into your router for correct operation, see PORTS


## Hostname, DNS, SSL

To provide public facing services, you'll need a public dns name, and an SSL certificate
You can request a hostname from mazatribe if you don't have a domain name registered.

maza related hostnames or domainnames are preferred
 ```
 maza.guruvan.net
 mazanode.maza.club
 mazanode.yourdomain.com
 maza.yourdomain.com
 ```
 etc

Once you have a domain name registered (if desired) you'll need an ssl certificate
this will acquire one via Letsencrypt, and save it locally. 
All of the images and docker-compose files are configured to use letsencrypt certs


 ```
 docker run -it --rm -v $(pwd)/letsencrypt:/etc/letsencrypt certbot/certbot 
 ```
 (TODO: finish letsencrypt command) 

## DATA 

 ```
 docker compose up -d ipfs
 docker-enter mazanode_ipfs_1
 ipfs pin add -r QmWsmEE9PL9rTiJtdayp8cfQoMcMqhgwxZodqtPa6A5NM9
 ipfs get -o /data/tarballs QmWsmEE9PL9rTiJtdayp8cfQoMcMqhgwxZodqtPa6A5NM9/MAZA/mazanodes/databases/mongodb-data_20171223.tbz2
  ```

  (add similar for electrum data) 


## PORTS

Forward these ports if needed:

 - 12825 - mazad p2p port 
 - 4001  - ipfs 
 - 80    - http
 - 443   - https
 - ????? - cjdns (UDP!) 
 - 53    - dns (maza-seeder)
 - 

Limit access to these to secure networks:

 - 12832 - mazad rpc, traffic should be limited to secure networks

