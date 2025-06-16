FROM tomcat:9.0-jdk17

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Install curl
RUN apt-get update && apt-get install -y curl

# Download Laundry.war from Google Drive
RUN curl -L -o /usr/local/tomcat/webapps/ROOT.war "https://drive.google.com/uc?export=download&id=1eFnLECPp3dsPVwE4W3iPXG61eeVg9ILP"

ENV PORT=8080
EXPOSE 8080

CMD ["catalina.sh", "run"]
