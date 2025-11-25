FROM tomcat:10.1-jdk17

# Remove default ROOT
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your WAR to ROOT
COPY target/UnsentLetters.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
