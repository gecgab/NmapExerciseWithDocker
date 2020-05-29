FROM psecubuntu

RUN echo 'root:root' | chpasswd

RUN apt-get update
RUN apt-get install -y telnetd
COPY passwords /root/passwords

ENTRYPOINT /etc/init.d/openbsd-inetd start && /bin/bash

