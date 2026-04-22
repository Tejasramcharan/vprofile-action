# ----------- Build Stage -----------
FROM maven:3.9.9-eclipse-temurin-11 AS BUILD_IMAGE

WORKDIR /app
COPY . .

RUN mvn clean package -DskipTests


# ----------- Runtime Stage -----------
FROM tomcat:9.0.89-jdk11-temurin

LABEL project="Vprofile"
LABEL author="Imran"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE /app/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]