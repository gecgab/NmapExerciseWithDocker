FROM psec-image00

RUN echo 'root:root' | chpasswd

RUN apt-get install -y telnetd

COPY passwords /root/employees/passwords
COPY names /root/employees/names
COPY index.html /var/www/html/index.html
COPY tiles.gif /var/www/html/tiles.gif

RUN chmod 555 /var/www/html/index.html && chmod 555 /var/www/html/tiles.gif

ENTRYPOINT service apache2 start && /etc/init.d/openbsd-inetd start && /bin/bash

EXPOSE 80