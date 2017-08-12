FROM alpine:3.5
RUN  apk --update add --no-cache ttf-dejavu fontconfig	\
		openjdk8  \
	&& rm -f /tmp/* \
	&& export JAVA_HOME=$(readlink -f /usr/lib/jvm/default-jvm)	\
	&& java -version
