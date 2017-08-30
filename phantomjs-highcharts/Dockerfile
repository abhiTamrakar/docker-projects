FROM ubuntu:16.04
LABEL maintainer="Abhishek Tamrakar<abhishek.tamrakar08@gmail.com>"
EXPOSE 3030
RUN \
        apt-get update -y \
        && apt-get install -y bzip2 curl libfontconfig \
# install node from source
        && curl -sL https://deb.nodesource.com/setup_4.x | bash - \
# then update with the newest packages
        && apt-get install nodejs -y \
	&& \
# its always better to give it a check
		if [ $(which npm) = "" ]; then \
		echo "NPM not installed!!";	\
		exit 1; \
		fi \
# highcharts has phantomjs dependency so let it install itself.
	&& npm install -g highcharts-phantomjs  \
# make sure we use 0.0.0.0 instead of localhost, it helps with conncetions from outer world
        && sed -i '13s/127.0.0.1/0.0.0.0/g' /usr/lib/node_modules/highcharts-phantomjs/server.js \
# few libraries can be left over to other directories, lets recollect them.
	&& cp -rpv /usr/lib/node_modules/highcharts-phantomjs/node_modules/highcharts/* \
		/usr/lib/node_modules/highcharts-phantomjs/lib/ \
# finally cleanup
	&& rm -rf /tmp/* \
	&& apt-get remove bzip2 -y \
	&& apt autoremove -y
# and how would you forget to start the game?
CMD highcharts-phantomjs start

