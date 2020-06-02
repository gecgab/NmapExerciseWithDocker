FROM psec-image00

RUN bash -c "echo -e Listen 53 > /etc/apache2/ports.conf"
COPY index.html /var/www/html/index.html

ENTRYPOINT iptables -A INPUT -m mac --mac-source 02:42:8f:c2:89:00 -j DROP && service apache2 start && /bin/bash
