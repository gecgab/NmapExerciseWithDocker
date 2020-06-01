FROM psec-image00

# install knockd
RUN apt-get -y install knockd

RUN sed -i 's/\[openSSH\]/[openHTTP]/' /etc/knockd.conf
RUN sed -i 's/\[closeSSH\]/[closeHTTP]/' /etc/knockd.conf
RUN sed -i 's/7000,8000,9000/1234,1337,4321/' /etc/knockd.conf
RUN sed -i 's/9000,8000,7000/4321,1337,1234/' /etc/knockd.conf
RUN sed -i 's/-A\sINPUT/-I INPUT 1/' /etc/knockd.conf
RUN sed -i 's/--dport 22/--dport 80/g' /etc/knockd.conf
RUN sed -i 's/START_KNOCKD=0/START_KNOCKD=1/' /etc/default/knockd

COPY index.html /var/www/html/index.html
COPY nmap_bnr_matrix_iain.gif /var/www/html/nmap_bnr_matrix_iain.gif

ENTRYPOINT iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT && \
	iptables -A INPUT -j DROP && \
	service knockd start &&  \
	service apache2 start && \
	/bin/bash

EXPOSE 80
