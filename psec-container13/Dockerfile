FROM psec-image00

COPY index.html /var/www/html/index.html

ENTRYPOINT iptables -A INPUT -m mac --mac-source 08:00:27:16:af:d8 -j DROP && service apache2 start && /bin/bash

EXPOSE 80
