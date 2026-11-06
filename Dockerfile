FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY --chown=10001:10001 voltaris-auth-service.jar /app/voltaris-auth-service.jar
COPY --chown=10001:10001 postgresql.jar /app/postgresql.jar
USER 10001:10001
ENV PORT=10000
EXPOSE 10000
ENTRYPOINT ["java", "-Dsun.net.httpserver.maxReqTime=10", "-Dsun.net.httpserver.maxRspTime=10", "-XX:MaxRAMPercentage=50.0", "-XX:+ExitOnOutOfMemoryError", "-cp", "/app/voltaris-auth-service.jar:/app/postgresql.jar", "lq.antileak.AuthorizationHostedMain"]
