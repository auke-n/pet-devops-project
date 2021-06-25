FROM openjdk:8-jdk-alpine
EXPOSE 8080
ARG JAR=*.jar
COPY target/$JAR /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]