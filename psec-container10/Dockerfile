FROM psec-image00

RUN bash -c "echo -e Listen 82 > /etc/apache2/ports.conf"

ENTRYPOINT service apache2 start && \
	iptables -P INPUT DROP && \
	iptables -A INPUT -p tcp --tcp-flags ALL NONE -j ACCEPT && \
	/bin/bash
