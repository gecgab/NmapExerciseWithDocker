FROM psec-image00

ENTRYPOINT /bin/bash -c "nc -l 22 &" && \
	/bin/bash -c "nc -l 53 &" && \
	/bin/bash -c "nc -l 99 &" && \
	/bin/bash -c "nc -l 1234 &" && \
	/bin/bash