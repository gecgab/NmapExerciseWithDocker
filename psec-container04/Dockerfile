FROM psec-image00

RUN apt-get install -y git
RUN apt-get install -y make
RUN apt-get install -y gcc
RUN apt-get remove -y openssl

RUN git clone https://github.com/chouqpy/openssl-1.0.1.git
#RUN /bin/bash cd ./openssl-1.0.1/ && ./config && make && make install
RUN cd ./openssl-1.0.1/ && ./config && make && make install_sw


# do steps from https://www.maketecheasier.com/apache-server-ssl-support/ still does not work

ENTRYPOINT /bin/bash

EXPOSE 80