FROM ubuntu:latest

RUN apt-get update
RUN apt-get -y install net-tools
RUN apt-get -y install iproute2
RUN apt-get -y install iptables
RUN apt-get -y install vim
RUN apt-get -y install ipset
RUN apt-get -y install ncat


## for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true


## preesed tzdata, update package index, upgrade packages and install needed software
RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \
    echo "tzdata tzdata/Zones/Europe select Berlin" >> /tmp/preseed.txt; \
    debconf-set-selections /tmp/preseed.txt && \
    apt-get update && \
    apt-get install -y tzdata

RUN apt-get -y install apache2

ENTRYPOINT service apache2 start && /bin/bash

EXPOSE 80
