#!/bin/bash
set -e

echo "setting up iptables"
echo "$1"
iptables -A INPUT -m mac --mac-source "$1" -j DROP
iptables -L
echo "iptables done"
echo "starting apache2 service"
service apache2 start
service apache2 status
echo "apache2 service is running"
/bin/bash