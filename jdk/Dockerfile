FROM alpine:latest
RUN set -x \
	&& apk --update add --no-cache \
		openjdk8  \
	&& rm -f /tmp/* \
	&& export JAVA_HOME=$(readlink -f /usr/lib/jvm/default-jvm)	\
	&& java -version
