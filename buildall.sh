#!/bin/bash

## create network
docker network create --driver=bridge --subnet=172.20.0.0/20 -o com.docker.network.bridge.name=psec-net psec-net

## build containers
docker build -t psec-image00 ./psec-container00 # standard ubuntu (has to be built first)

docker build -t psec-image06 ./psec-container06 # telnet

## firewall evasion
docker build -t psec-image10 ./psec-container10
docker build -t psec-image11 ./psec-container11
docker build -t psec-image12 ./psec-container12
