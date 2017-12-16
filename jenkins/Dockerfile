FROM iabhi/jdk:1.8.121

LABEL maintainer="Abhishek Tamrakar<abhishek.tamrakar08@gmail.com>"
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk 
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$JAVA_HOME
ENV JENKINS_HOME /var/lib/jenkins
ENV PATH $JENKINS_HOME/bin:$PATH
WORKDIR $JENKINS_HOME
RUN apk --update add wget ca-certificates openssl bash bash-completion bash-doc	git \
	&& wget https://updates.jenkins-ci.org/latest/jenkins.war -O /tmp/jenkins.war
EXPOSE 8080
CMD nohup java -jar /tmp/jenkins.war >&2
