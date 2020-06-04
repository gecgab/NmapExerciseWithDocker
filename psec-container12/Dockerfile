FROM psec-image00

RUN apt-get -y install ipset

COPY index.html /var/www/html/index.html
RUN bash -c "echo -e Listen 76 > /etc/apache2/ports.conf"

ENTRYPOINT service apache2 start && \
	ipset create port_scanners hash:ip family inet hashsize 32768 maxelem 65536 timeout 2 && \
	ipset create scanned_ports hash:ip,port family inet hashsize 32768 maxelem 65536 timeout 1 && \
	iptables -A INPUT -m state --state INVALID -j DROP && \
	iptables -A INPUT -m state --state NEW -m set ! --match-set scanned_ports src,dst -m hashlimit --hashlimit-above 1/hour --hashlimit-burst 7 --hashlimit-mode srcip --hashlimit-name portscan --hashlimit-htable-expire 2000 -j SET --add-set port_scanners src --exist && \
	iptables -A INPUT -m state --state NEW -m set --match-set port_scanners src -j DROP && \
	iptables -A INPUT -m state --state NEW -j SET --add-set scanned_ports src,dst && \
	/bin/bash

EXPOSE 76