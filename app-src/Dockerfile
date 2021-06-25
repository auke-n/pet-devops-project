FROM adoptopenjdk/openjdk11:alpine
EXPOSE 8080
ARG JAR=spring-petclinic-2.4.6.jar
COPY target/*.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]