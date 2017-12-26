#!/bin/sh


dir=$(pwd|awk -F\/ '{print $NF}')
if [ "${dir}" != "mazanode" ] ; then 
   echo "Please ensure you're in the main \
     mazanode directory before running this script"
   exit 1
fi

docker run -it --rm \
  --name letsencrypt_certbot \
  --entrypoint /bin/ash \
  -v $(pwd)/letsencrypt:/etc/letsencrypt \
  -v $(pwd)/letsencrypt-logs:/var/log/letsencrypt \
  --net host certbot/certbot

