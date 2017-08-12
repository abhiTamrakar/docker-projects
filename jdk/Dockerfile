FROM alpine:3.6
ENV JAVA_HOME /usr/local/java/jdk
ENV PATH ${PATH}:/usr/local/java/jdk/bin
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$JAVA_HOME:/usr/lib:/lib/
RUN apk --update --no-cache add \
	ca-certificates \
	openssl-dev \
        tar \
        sqlite \
        icu \
        fontconfig \
        ttf-dejavu \
        font-adobe-100dpi \
        && mkdir ${JAVA_HOME%\/*} \
	&& wget --no-check-certificate -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
	&& wget --no-check-certificate https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk -O /tmp/glibc-2.25-r0.apk \
	&& wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.tar.gz -O /tmp/jdk-8u144-linux-x64.tar.gz \
	&& apk add glibc-2.25-r0.apk	\
	&& \
  cd ${JAVA_HOME%\/*} \
  && tar -xvf /tmp/jdk-8u144-linux-x64.tar.gz \
  && ln -s /usr/local/java/jdk1.8.0_144 /usr/local/java/jdk \
  && java -version \
  && apk del \
	tar \
	wget \
	ca-certificates \
  && rm -frv /tmp/*
