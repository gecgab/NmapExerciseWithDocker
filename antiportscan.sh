#!/bin/bash

port=20
batch=7

while [ $port -le 80 ]
do
	nmap -n 172.20.1.12 -p$port-$(($port+$batch-1))
	sleep 3
	((port+=$batch))
done
