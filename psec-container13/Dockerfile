FROM psec-image00

RUN bash -c "echo -e Listen 55 > /etc/apache2/ports.conf"
COPY index.html /var/www/html/index.html

ENTRYPOINT iptables -A INPUT -m mac --mac-source 08:00:27:16:af:d8 -j DROP && service apache2 start && /bin/bash
