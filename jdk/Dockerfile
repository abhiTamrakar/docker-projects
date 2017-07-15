FROM frolvlad/alpine-glibc:alpine-3.5
RUN apk --update add sqlite icu --no-cache
ENV JAVA_HOME /usr/local/java/jdk
ENV PATH ${PATH}:/usr/local/java/jdk/bin
WORKDIR /usr/local/java
ADD http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz .
RUN set -x	\
	&& ln -s /usr/local/java/jdk1.8.0_131 /usr/local/java/jdk \
	&& apk del wget \
	&& rm -f /tmp/* 
