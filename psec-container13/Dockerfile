FROM psec-image00

COPY index.html /var/www/html/index.html

ENTRYPOINT iptables -A INPUT -m mac --mac-source 02:42:b1:b2:a0:f3 -j DROP && service apache2 start && /bin/bash

EXPOSE 80
