FROM adoptopenjdk/openjdk11:alpine
EXPOSE 8080
# ARG JAR=spring-petclinic-2.4.5.jar
COPY target/*.jar /app.jar
ENTRYPOINT ["java","-jar","java -jar target/app.jar"]