# Stage 1: Build JAR using Maven
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app
COPY . .

RUN mvn clean package -DskipTests

# Stage 2: Run the app
FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=builder /app/target/poc-demo-1.0.jar app.jar

EXPOSE 8081

ENTRYPOINT ["java","-jar","app.jar"]
