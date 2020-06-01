FROM psec-image00

ENTRYPOINT /bin/bash -c "nc -l 22 &" && \
	/bin/bash -c "nc -l 111 &" && \
	/bin/bash -c "nc -l 443 &" && \
	/bin/bash -c "nc -l 3480 &" && \
	/bin/bash -c "nc -l 3659 &" && \
	/bin/bash