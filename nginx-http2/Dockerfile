FROM alpine:latest
ENV VERSION=1.13.8

RUN apk --update add wget ca-certificates openssl bash bash-completion bash-doc alpine-sdk openssl-dev
#RUN wget http://nginx.org/download/nginx-${VERSION}.tar.gz -o nginx-${VERSION}.tar.gz \
ADD nginx-${VERSION}.tar.gz /usr/local/
ADD pcre-8.41.tar.gz /usr/local/
ADD zlib-1.2.11.tar.gz /usr/local/
WORKDIR /usr/local/nginx-${VERSION}
EXPOSE 80 443
RUN ./configure	\
	    --sbin-path=/usr/bin/nginx		\
	    --conf-path=/etc/nginx/nginx.conf	\
	    --pid-path=/usr/local/nginx/nginx.pid	\
	    --with-http_ssl_module			\
	    --with-http_v2_module			\
	    --with-stream				\
	    --with-mail=dynamic				\
	    --with-pcre=../pcre-8.41			\
	    --with-zlib=../zlib-1.2.11			\
		&& make 				\
		&& make install				\
		&& mkdir -p /etc/nginx/ssl /var/www/html 
COPY ssl/* /etc/nginx/ssl/
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /var/www/html/index.html
COPY startNginx.sh /root/
WORKDIR /etc/nginx
RUN nginx -t	\
	&& ln -s /usr/local/nginx-${VERSION} /usr/local/nginx \
	&& chmod 755 /root/startNginx.sh
ENTRYPOINT ["/root/startNginx.sh"]
