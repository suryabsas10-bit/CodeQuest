
FROM tomcat:10.1-jdk17-temurin

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy CodeQuest as the root application
COPY target/CodeQuest.war /usr/local/tomcat/webapps/ROOT.war

# Start Tomcat using the port assigned by Render
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
