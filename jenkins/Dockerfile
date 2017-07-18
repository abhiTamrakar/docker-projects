FROM jdk:1.8.131

ENV JAVA_HOME /usr/bin/java

# let "Tomcat Native" live somewhere isolated
ENV TOMCAT_NATIVE_LIBDIR $CATALINA_HOME/native-jni-lib
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$TOMCAT_NATIVE_LIBDIR

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.5.15

ENV CATALINA_HOME /usr/local/apache-tomcat-8.5.15
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME

RUN set -x \
	\
	&& apk add --no-cache --virtual .fetch-deps \
		ca-certificates \
		tar \
		openssl	\
		wget	\
	&& wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz -O /tmp/apache-tomcat-8.5.15.tar.gz	\
	&& tar -xvf /tmp/apache-tomcat-8.5.15.tar.gz 	\
	&& rm -rf $CATALINA_HOME/webapps/docs $CATALINA_HOME/webapps/examples \
	&& nativeBuildDir="$(mktemp -d)" \
	&& tar -xvf $CATALINA_HOME/bin/tomcat-native.tar.gz -C "$nativeBuildDir" --strip-components=1 \
	&& apk add --no-cache --virtual .native-build-deps \
		apr-dev \
		dpkg-dev dpkg \
		gcc \
		libc-dev \
		make \
		openssl-dev \
	&& ( \
		export CATALINA_HOME="$PWD" \
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
	&& rm -rf "$nativeBuildDir" /tmp/* \
	&& rm $CATALINA_HOME/bin/tomcat-native.tar.gz	\
# verify Tomcat Native is working properly
	&& set -e \
	&& nativeLines="$(catalina.sh configtest 2>&1)" \
	&& nativeLines="$(echo "$nativeLines" | grep 'Apache Tomcat Native')" \
	&& nativeLines="$(echo "$nativeLines" | sort -u)" \
	&& if ! echo "$nativeLines" | grep 'INFO: Loaded APR based Apache Tomcat Native library' >&2; then \
		echo >&2 "$nativeLines"; \
		exit 1; \
	fi
ADD https://updates.jenkins-ci.org/latest/jenkins.war $CATALINA_HOME/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]
