FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY --chown=10001:10001 voltaris-auth-service.jar /app/voltaris-auth-service.jar
USER 10001:10001
ENV PORT=10000
EXPOSE 10000
ENTRYPOINT ["java", "-XX:MaxRAMPercentage=50.0", "-XX:+ExitOnOutOfMemoryError", "-cp", "/app/voltaris-auth-service.jar", "lq.antileak.AuthorizationHostedMain"]
