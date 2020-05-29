# [https://wiki.archlinux.org/index.php/Simple_stateful_firewall#Protection_against_spoofing_attacks]
## discard certain IP - was kann man tun, wenn IP geblockt wird?
iptables -A INPUT -s 172.17.0.1 -j DROP

## evade syn scan
iptables -N TCP
iptables -N TCP-PORTSCAN
iptables -I TCP -p tcp -m recent --update --rsource --seconds 60 --name TCP-PORTSCAN -j REJECT --reject-with tcp-reset
iptables -D INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p tcp -m recent --set --rsource --name TCP-PORTSCAN -j REJECT --reject-with tcp-reset

## - brute force (wenn es erwaehnt wird)
iptables -N IN_SSH
iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -j IN_SSH
iptables -A IN_SSH -m recent --name sshbf --rttl --rcheck --hitcount 3 --seconds 10 -j DROP
iptables -A IN_SSH -m recent --name sshbf --rttl --rcheck --hitcount 4 --seconds 1800 -j DROP 
iptables -A IN_SSH -m recent --name sshbf --set -j ACCEPT

## Accept NULL packets
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j ACCEPT

## general port scan evasion (does not work)
iptables -N port-scan
iptables -A port-scan -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j RETURN
iptables -A port-scan -j DROP


## new attempt
ipset create port_scanners hash:ip family inet hashsize 32768 maxelem 65536 timeout 10
ipset create scanned_ports hash:ip,port family inet hashsize 32768 maxelem 65536 timeout 5

iptables -A INPUT -m state --state INVALID -j DROP
iptables -A INPUT -m state --state NEW -m set ! --match-set scanned_ports src,dst -m hashlimit --hashlimit-above 1/hour --hashlimit-burst 5 --hashlimit-mode srcip --hashlimit-name portscan --hashlimit-htable-expire 10000 -j SET --add-set port_scanners src --exist
iptables -A INPUT -m state --state NEW -m set --match-set port_scanners src -j DROP
iptables -A INPUT -m state --state NEW -j SET --add-set scanned_ports src,dst
