#!/bin/bash

## create network
docker network create --driver=bridge --subnet=172.20.0.0/20 -o com.docker.network.bridge.name=psec-net psec-net

## PULL Metasploitable Container!!
# docker pull tleemcjr/metasploitable2

## build containers
docker build -t psec-image00 ./psec-container00 # standard ubuntu (has to be built first)

docker build -t psec-image02 ./psec-container02 # ubuntu with nc
#			       psec-container03 # nginx 
docker build -t psec-image05 ./psec-container05 # ubuntu with samba
docker build -t psec-image06 ./psec-container06 # telnet
docker build -t psec-image07 ./psec-container07 # ubuntu with nc
#			       psec-container09 # metasploitable

## firewall evasion
docker build -t psec-image10 ./psec-container10
docker build -t psec-image11 ./psec-container11
docker build -t psec-image12 ./psec-container12
docker build -t psec-image13 ./psec-container13

# mini CTF
docker build -t psec-image20 ./psec-container20
docker build -t psec-image21 ./psec-container21
docker build -t psec-image22 ./psec-container22



