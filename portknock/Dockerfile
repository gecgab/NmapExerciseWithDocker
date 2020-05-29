FROM psecubuntu:latest

RUN apt-get update 
RUN apt-get install -y openssh-server

# install knockd
RUN apt-get -y install knockd

#ssh config
RUN mkdir /var/run/sshd
RUN echo 'root:s3cure' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN sed -i 's/-A\sINPUT/-I INPUT 1/' /etc/knockd.conf
RUN sed -i 's/START_KNOCKD=0/START_KNOCKD=1/' /etc/default/knockd

ENTRYPOINT iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT && iptables -A INPUT -j DROP && service knockd start &&  service ssh restart && /bin/bash
# CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 22
