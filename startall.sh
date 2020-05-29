#!/bin/bash

docker build -t psecubuntu ./psecubuntu
docker build -t portspoof ./portspoof
docker build -t portknock ./portknock

## force remove all containers
docker rm $(docker ps -a -q) --force

## create network
docker network create --driver=bridge --subnet=172.20.0.0/16 -o com.docker.network.bridge.name=psec-lab-net psec-lab-net

## run containers and exec commands

### sourceport1 p18
docker run -dit --cap-add=NET_ADMIN --restart unless-stopped --network=psec-lab-net --ip=172.20.2.1 --name=psecubuntu1 psecubuntu
docker exec -it psecubuntu1 bash -c "echo -e Listen 18 > /etc/apache2/ports.conf"
docker exec -it psecubuntu1 iptables -P INPUT DROP
docker exec -it psecubuntu1 iptables -A INPUT -p tcp --sport 71 -j ACCEPT

### accept null packets p93
docker run -dit --cap-add=NET_ADMIN --restart unless-stopped --network=psec-lab-net --ip=172.20.2.2 --name=psecubuntu2 psecubuntu
docker exec -it psecubuntu2 bash -c "echo -e Listen 93 > /etc/apache2/ports.conf"
docker exec -it psecubuntu2 iptables -P INPUT DROP
docker exec -it psecubuntu2 iptables -A INPUT -p tcp --tcp-flags ALL NONE -j ACCEPT

### sourceport2 p91
docker run -dit --cap-add=NET_ADMIN --restart unless-stopped --network=psec-lab-net --ip=172.20.2.3 --name=psecubuntu3 psecubuntu
docker exec -it psecubuntu3 bash -c "echo -e Listen 91 > /etc/apache2/ports.conf" 
docker exec -it psecubuntu3 iptables -P INPUT DROP
docker exec -it psecubuntu3 iptables -A INPUT -p tcp --sport 42 -j ACCEPT

### portspoof
docker run -dit --cap-add=NET_ADMIN --restart unless-stopped --network=psec-lab-net --ip=172.20.2.4 --name=psecubuntu4 portspoof

### anti portscan firewall p27
docker run -dit --cap-add=NET_ADMIN --restart unless-stopped --network=psec-lab-net --ip=172.20.2.5 --name=psecubuntu5 psecubuntu
docker exec -it psecubuntu5 bash -c "echo -e Listen 27 > /etc/apache2/ports.conf"
docker exec -it psecubuntu5 ipset create port_scanners hash:ip family inet hashsize 32768 maxelem 65536 timeout 10
docker exec -it psecubuntu5 ipset create scanned_ports hash:ip,port family inet hashsize 32768 maxelem 65536 timeout 5
docker exec -it psecubuntu5 iptables -A INPUT -m state --state INVALID -j DROP
docker exec -it psecubuntu5 iptables -A INPUT -m state --state NEW -m set ! --match-set scanned_ports src,dst -m hashlimit --hashlimit-above 1/hour --hashlimit-burst 5 --hashlimit-mode srcip --hashlimit-name portscan --hashlimit-htable-expire 10000 -j SET --add-set port_scanners src --exist
docker exec -it psecubuntu5 iptables -A INPUT -m state --state NEW -m set --match-set port_scanners src -j DROP
docker exec -it psecubuntu5 iptables -A INPUT -m state --state NEW -j SET --add-set scanned_ports src,dst

### portknock
docker run -dit --cap-add=NET_ADMIN --restart unless-stopped --network=psec-lab-net --ip=172.20.3.17 --name=psecubuntu6 portknock

### statist1 - psecubuntu7
docker run -dit --cap-add=NET_ADMIN --restart unless-stopped --network=psec-lab-net --ip=172.20.0.7 --name=psecubuntu7 psecubuntu

### statist2 - psecubuntu8
docker run -dit --cap-add=NET_ADMIN --restart unless-stopped --network=psec-lab-net --ip=172.20.0.8 --name=psecubuntu8 psecubuntu

### statist3 - psecubuntu9
docker run -dit --cap-add=NET_ADMIN --restart unless-stopped --network=psec-lab-net --ip=172.20.0.9 --name=psecubuntu9 psecubuntu
#docker exec psecubuntu5 nc -l 21 &
#docker exec psecubuntu5 nc -l 1024 &
#docker exec psecubuntu5 nc -l 443 &


## Apache seems to be a little fuzzy...
sleep 2

docker exec -it psecubuntu1 service apache2 restart
docker exec -it psecubuntu2 service apache2 restart
docker exec -it psecubuntu3 service apache2 restart
docker exec -it psecubuntu5 service apache2 restart

# "Listen 27\n\n<IfModule ssl_module>\n        Listen 443\n</IfModule>\n\n<IfModule mod_gnutls.c>\n        Listen 443\n</IfModule>" 
