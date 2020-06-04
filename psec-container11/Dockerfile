FROM psec-image00

RUN bash -c "echo -e Listen 21 > /etc/apache2/ports.conf"
COPY index.html /var/www/html/index.html

ENTRYPOINT service apache2 start && \
	iptables -P INPUT DROP && \
	iptables -A INPUT -p tcp --sport 20 -j ACCEPT && \
	/bin/bash

EXPOSE 21
