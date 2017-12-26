#!/bin/sh

git pull
docker pull maza/mazanode-mazad
docker pull maza/mazanode-iquidus
docker pull maza/mazanode-mongodb
docker pull maza/mazanode-tateserver

