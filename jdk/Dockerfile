FROM alpine:latest
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
RUN  apk --update add --no-cache ttf-dejavu fontconfig	\
		openjdk8  \
	&& rm -f /tmp/* \
	&& java -version
