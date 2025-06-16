FROM tomcat:9.0-jdk17

# Remove default web apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from dist folder
COPY dist/Laundry.war /usr/local/tomcat/webapps/ROOT.war

ENV PORT=8080
EXPOSE 8080

CMD ["catalina.sh", "run"]
