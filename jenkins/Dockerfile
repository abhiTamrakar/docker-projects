FROM jdk:1.8.121

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk 
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$JAVA_HOME
# let "Tomcat Native" live somewhere isolated
ENV JENKINS_HOME /var/lib/jenkins
ENV PATH $JENKINS_HOME/bin:$PATH
WORKDIR $JENKINS_HOME

RUN apk --update add wget ca-certificates openssl \
	&& wget https://updates.jenkins-ci.org/download/war/2.70/jenkins.war -O ./jenkins.war

EXPOSE 8080
CMD nohup java -jar jenkins.war >&2
