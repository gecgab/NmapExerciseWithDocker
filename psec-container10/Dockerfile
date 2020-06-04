FROM psec-image00

RUN apt-get -y install git
RUN apt-get -y install build-essential
RUN git clone https://github.com/drk1wi/portspoof
RUN cd portspoof && ./configure && make && make install

RUN bash -c "echo -e Listen 26 > /etc/apache2/ports.conf"
COPY index.html /var/www/html/index.html

ENTRYPOINT iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT && \
        iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 1:25 -j REDIRECT --to-ports 4444 && \
        iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 27:65535 -j REDIRECT --to-ports 4444 && \
        service apache2 start && portspoof -c portspoof/tools/portspoof.conf -s portspoof/tools/portspoof_signatures && /bin/bash

EXPOSE 26