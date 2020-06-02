FROM psec-image00

RUN bash -c "echo -e Listen 82 > /etc/apache2/ports.conf"

ENTRYPOINT iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT && \
        iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 1:81 -j REDIRECT --to-ports 4444 && \
        iptables -t nat -A PREROUTING -i eth0 -p tcp -m tcp --dport 83:65535 -j REDIRECT --to-ports 4444 && \
        service ssh restart && portspoof -c portspoof/tools/portspoof.conf -s portspoof/tools/portspoof_signatures && /bin/bash