FROM eclipse-temurin:17-jdk

WORKDIR /app

ADD target/*.jar agent.jar

CMD ["java", "-jar", "agent.jar"]
