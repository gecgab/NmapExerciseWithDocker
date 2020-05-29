FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server
RUN apt-get -y install net-tools
RUN apt-get -y install iproute2
RUN apt-get -y install iptables
RUN apt-get -y install git
RUN apt-get -y install build-essential
RUN git clone https://github.com/drk1wi/portspoof
RUN cd portspoof && ./configure && make && make install

#ssh config
RUN mkdir /var/run/sshd
RUN echo 'root:s3cure' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


ENTRYPOINT iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT && \
        iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 1:21 -j REDIRECT --to-ports 4444 && \
        iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 23:65535 -j REDIRECT --to-ports 4444 && \
        service ssh restart && portspoof -c portspoof/tools/portspoof.conf -s portspoof/tools/portspoof_signatures && /bin/bash
EXPOSE 22
