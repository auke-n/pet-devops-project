FROM maven:3.6.0-jdk-11-slim
COPY pom.xml .
COPY src /src
RUN mvn -f /pom.xml clean package

FROM openjdk:8-jdk-alpine
EXPOSE 8080
ARG JAR=spring-petclinic-2.4.5.jar
COPY target/$JAR /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]