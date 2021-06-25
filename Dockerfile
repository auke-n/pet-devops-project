FROM adoptopenjdk/openjdk11:alpine
EXPOSE 8080
ARG JAR=spring-petclinic-2.4.5.jar
COPY app-src/target/$JAR app-src/app.jar
ENTRYPOINT ["java","-jar","/app.jar"]