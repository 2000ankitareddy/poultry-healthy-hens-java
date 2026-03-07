FROM tomcat:9

RUN rm -f /usr/local/tomcat/webapps/*

COPY target/healthy-hens-1.0.war /usr/local/tomcat/webapps/healthy-hens.war

EXPOSE 2000
