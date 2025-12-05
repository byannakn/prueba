# Etapa 1: Build con Gradle 
FROM gradle:7.6.2-jdk17 AS build
WORKDIR /home/gradle/project

COPY . .
RUN chmod +x ./gradlew
RUN ./gradlew clean bootJar --no-daemon

# Etapa 2: Imagen 
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

COPY --from=build /home/gradle/project/build/libs/*SNAPSHOT.jar ./app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-Dserver.port=8080", "-Dserver.address=0.0.0.0", "-jar", "app.jar"]
cloud