#!/bin/bash

## force remove all containers
docker rm $(docker ps -a -q) --force

## ubuntu with nc listening to ports 22,111,443,3480,3659
docker run -dit --restart always --network=psec-net --ip=172.20.0.2 --name=psec-container02 psec-image02

## default nginx server (will be downloaded and built automatically)
docker run -dit --restart always --network=psec-net --ip=172.20.0.3 --name=psec-container03 nginx

## ubuntu with default samba running
docker run -dit --restart always --network=psec-net --ip=172.20.0.5 --name=psec-container05 psec-image05

## telnet
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.0.6 --name=psec-container06 psec-image06

## ubuntu with nc listening to ports 22,53,99,1234
docker run -dit --restart always --network=psec-net --ip=172.20.0.7 --name=psec-container07 psec-image07

## metasploitable
docker run -dit  --restart always --network=psec-net --ip=172.20.0.9 --name psec-container09 tleemcjr/metasploitable2:latest sh -c "/bin/services.sh && bash"

## nullscan
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.1.10 --name=psec-container10 psec-image10

## sourceport
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.1.11 --name=psec-container11 psec-image11

## antiportscan
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.1.12 --name=psec-container12 psec-image12

## Mac-Spoof
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.1.13 --name=psec-container13 psec-image13 "01:02:03:04:05:06"

## SSH Base64
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.15.20 --name=psec-container20 psec-image20

## SSH Port-Knock Instruction
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.15.21 --name=psec-container21 psec-image21

## http Finish
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.15.22 --name=psec-container22 psec-image22
