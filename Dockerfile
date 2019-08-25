FROM openjdk:8
ARG JAR_FILE_PATH
RUN mkdir /opt/spring-petclinic
COPY ${JAR_FILE_PATH} /opt/spring-petclinic/spring-petclinic.jar
ENTRYPOINT java -jar /opt/spring-petclinic/spring-petclinic.jar
EXPOSE 8080
