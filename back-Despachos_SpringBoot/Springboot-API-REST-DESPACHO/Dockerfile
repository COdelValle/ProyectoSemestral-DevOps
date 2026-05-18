# Multistage
# Stage 1
FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /build
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2
FROM eclipse-temurin:17-jdk

# Instalar netcat (nc) para que el script pueda comprobar el puerto
RUN apt-get update && apt-get install -y netcat-openbsd && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=builder /build/target/*.jar app.jar
COPY entrypoint.sh ./entrypoint.sh

# Darle permisos de ejecución al script
RUN chmod +x ./entrypoint.sh

EXPOSE 8081

# 🔹 CAMBIO CLAVE: Ahora ejecutamos el script, y el script ejecutará el JAR
ENTRYPOINT ["./entrypoint.sh"]