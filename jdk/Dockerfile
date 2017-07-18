FROM alpine:latest
ENV PATH ${PATH}:/usr/local/java/jdk/bin
WORKDIR /usr/local/java
RUN set -x \
	&& apk --update add --no-cache \
		openjdk8 which \
	&& rm -f /tmp/* \
	&& java -version
