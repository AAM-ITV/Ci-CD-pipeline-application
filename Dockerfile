FROM maven:3.8.6-openjdk-11-slim as maven_builder
COPY . /tmp/App42PaaS
WORKDIR /tmp/App42PaaS
RUN mvn clean install
FROM tomcat:9.0.0-jre8-alpine
COPY --from=maven_builder /tmp/App42PaaS/target/*.war /usr/local/tomcat/webapps
COPY --from=maven_builder /tmp/App42PaaS/WebContent/Config.properties /usr/local/tomcat/ROOT/Config.properties
EXPOSE 8080
