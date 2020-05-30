FROM psec-image00

RUN bash -c "echo -e Listen 18 > /etc/apache2/ports.conf"

ENTRYPOINT service apache2 start && \
	iptables -P INPUT DROP && \
	iptables -A INPUT -p tcp --sport 20 -j ACCEPT && \
	/bin/bash
