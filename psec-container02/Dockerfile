FROM psec-image00

ENTRYPOINT /bin/bash -c "nc -l 22 &" && \
	/bin/bash -c "nc -l 111 &" && \
	/bin/bash -c "nc -l 443 &" && \
	/bin/bash -c "nc -l 3128 &" && \
	/bin/bash -c "nc -l 6001 &" && \
	/bin/bash