FROM maven:3.8.6-amazoncorretto-17 as build

WORKDIR /app
COPY . .

RUN mvn clean package -X -DskipTests

FROM openjdk:17-ea-10-jdk-slim

WORKDIR /app

COPY --from=build /target/flamme-backend-0.0.1.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]