FROM maven:3-jdk-11 AS builder

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . .

RUN apt-get install maven -y
RUN mvn clean install

FROM openjdk:11-slim AS runtime

EXPOSE 8080

COPY --from=build /target/flamme-backend-0.0.1.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]