#!/bin/bash

## force remove all containers
docker rm $(docker ps -a -q) --force

## sourceport
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.0.6 --name=psec-container06 psec-image06

## nullscan
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.1.10 --name=psec-container10 psec-image10

## sourceport
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.1.11 --name=psec-container11 psec-image11

## antiportscan
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.1.12 --name=psec-container12 psec-image12

## SSH Base64
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.15.20 --name=psec-container20 psec-image20

## SSH Port-Knock Instruction
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.15.21 --name=psec-container21 psec-image21

## http Finish
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.15.22 --name=psec-container22 psec-image22