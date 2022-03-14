FROM openjdk:11.0.4-jre-slim
ARG JAR_FILE=*.jar
COPY ${JAR_FILE} app.jar
EXPOSE 9090
ENTRYPOINT ["java","-jar","/app.jar"]
