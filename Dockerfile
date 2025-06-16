FROM tomcat:9.0-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

# Download WAR from Google Drive (use direct download link)
ADD https://drive.google.com/uc?export=download&id=1eFnLECPp3dsPVwE4W3iPXG61eeVg9ILP /usr/local/tomcat/webapps/ROOT.war

ENV PORT=8080
EXPOSE 8080

CMD ["catalina.sh", "run"]
