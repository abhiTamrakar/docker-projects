FROM iabhi/jdk:latest

LABEL maintainer="Abhishek Tamrakar<abhishek.tamrakar08@gmail.com>"
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
# let "Tomcat Native" live somewhere isolated
ENV TOMCAT_NATIVE_LIBDIR $CATALINA_HOME/native-jni-lib
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$TOMCAT_NATIVE_LIBDIR
ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.5.23
ENV CATALINA_HOME /usr/local/apache-tomcat-8.5.23
ENV PATH $CATALINA_HOME/bin:$PATH
#ADD apache-tomcat-8.5.23.tar.gz /usr/local/
WORKDIR $CATALINA_HOME
RUN set -x \
	\
	&& apk add --virtual .fetch-deps \
		ca-certificates \
		tar \
		openssl	\
		wget	\
	&& wget http://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.23/bin/apache-tomcat-8.5.23.tar.gz -O /usr/local/apache-tomcat-8.5.23.tar.gz	\
	&& cd /usr/local	\
	&& tar -xvf apache-tomcat-8.5.23.tar.gz	\
	&& rm -rf $CATALINA_HOME/webapps/docs $CATALINA_HOME/webapps/examples \
	&& nativeBuildDir="$(mktemp -d)" \
	&& tar -xvf $CATALINA_HOME/bin/tomcat-native.tar.gz -C "$nativeBuildDir" --strip-components=1 \
	&& apk add --virtual .native-build-deps \
		apr-dev \
		dpkg-dev dpkg \
		gcc \
		libc-dev \
		make \
		openssl-dev \
	&& ( \
		export CATALINA_HOME="$CATALINA_HOME" \
		&& cd "$nativeBuildDir/native" \
		&& gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
		&& ./configure \
			--build="$gnuArch" \
			--libdir="$TOMCAT_NATIVE_LIBDIR" \
			--prefix="$CATALINA_HOME" \
			--with-apr="$(which apr-1-config)" \
			--with-java-home="$JAVA_HOME" \
			--with-ssl=yes \
		&& make -j$(getconf _NPROCESSORS_ONLN) \
		&& make install \
	) \
	&& runDeps="$( \
		scanelf --needed --nobanner --recursive "$TOMCAT_NATIVE_LIBDIR" \
			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
			| sort -u \
			| xargs -r apk info --installed \
			| sort -u \
	)" \
	&& apk add --virtual .tomcat-native-rundeps $runDeps \
	&& apk del .fetch-deps .native-build-deps \
	&& rm -rf "$nativeBuildDir" \
	&& rm $CATALINA_HOME/bin/tomcat-native.tar.gz /usr/local/apache-tomcat-8.5.23.tar.gz
# verify Tomcat Native is working properly
RUN set -e \
	&& nativeLines="$(catalina.sh configtest 2>&1)" \
	&& nativeLines="$(echo "$nativeLines" | grep 'Apache Tomcat Native')" \
	&& nativeLines="$(echo "$nativeLines" | sort -u)" \
	&& if ! echo "$nativeLines" | grep 'INFO: Loaded APR based Apache Tomcat Native library' >&2; then \
		echo >&2 "$nativeLines"; \
		exit 1; \
	fi
EXPOSE 8080
CMD ["catalina.sh", "run"]
