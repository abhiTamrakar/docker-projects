#!/bin/bash
#
# wrapper script by Abhishek Tamrakar
#
set -e 

/usr/bin/nginx && \
	echo -e "Nginx started"	\
	|| echo -e "Nginx failed"

#run it forever
#
tail -f /dev/null
