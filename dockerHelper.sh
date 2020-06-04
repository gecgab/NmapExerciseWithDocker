#!/bin/bash

# put this script into /etc/init.d/

macNotFound=true
while "$macNotFound"; do
    kaliMAC=$(ifconfig | pcregrep -M -o "psec\-net.*(\n|.)*\K02:42(:\w\w){4}")
    if [ "$kaliMAC" != "" ]
    then
        macNotFound=false
    fi
done

docker stop psec-container13 > /dev/null 2>&1 && docker rm psec-container13 > /dev/null 2>&1 || :
docker run -dit --cap-add=NET_ADMIN --restart always --network=psec-net --ip=172.20.1.13 --name=psec-container13 psec-image13 "$kaliMAC" > /dev/null 2>&1
