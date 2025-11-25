# Stage 1 — Build the WAR
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn -B -DskipTests package

# Stage 2 — Deploy on Tomcat
FROM tomcat:10.1-jdk17

# Remove default ROOT
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy WAR from Maven build (works for any name)
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
