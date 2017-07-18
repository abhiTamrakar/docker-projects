FROM alpine:latest
RUN set -x \
	&& apk --update add --no-cache \
		openjdk8  \
	&& rm -f /tmp/* \
	&& java -version
