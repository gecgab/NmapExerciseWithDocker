FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server
RUN apt-get -y install net-tools
RUN apt-get -y install iproute2
RUN apt-get -y install iptables


#ssh config
RUN mkdir /var/run/sshd
RUN useradd -ms /bin/bash admin
RUN echo 'admin:Supr3m3p455w0rd' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN cd home/admin/ && echo "host: 172.20.15.22" > host.txt && \
	echo "Knock Knock: 1234 1337 4321" > knock-order.txt && \
	echo "Close Port: 4321 1337 1234" >> knock-order.txt && \
	echo "Protocol: none" >> knock-order.txt && \
	echo "knocking with kali: knock <host> <port[:proto]> [<port>[:proto]] ..." > knockWithKali.txt


ENTRYPOINT iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT &&  service ssh restart && /bin/bash

EXPOSE 22

