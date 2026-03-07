FROM tomcat:9

RUN rm -f /usr/local/tomcat/webapps/*

COPY target/*.war /usr/local/tomcat/webapps/

EXPOSE 8080
