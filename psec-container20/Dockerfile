FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server
RUN apt-get -y install net-tools
RUN apt-get -y install iproute2
RUN apt-get -y install iptables


#ssh config
RUN mkdir /var/run/sshd
RUN echo 'root:s3cure' | chpasswd
RUN useradd -ms /bin/bash john
RUN echo 'john:theRipper' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# create important files for the user
RUN cd root/ && echo "YWRtaW46U3VwcjNtM3A0NTV3MHJk" > credentials.txt
RUN cd home/john/ && touch emptyFile


ENTRYPOINT iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT &&  service ssh restart && /bin/bash

EXPOSE 22

