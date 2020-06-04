FROM psec-image00

RUN bash -c "echo -e Listen 53 > /etc/apache2/ports.conf"
COPY index.html /var/www/html/index.html
COPY commands.sh /scripts/commands.sh
RUN ["chmod", "+x", "/scripts/commands.sh"]

ENTRYPOINT ["/scripts/commands.sh"]

EXPOSE 53