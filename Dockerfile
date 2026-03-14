FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y maven
RUN mvn clean package
ENV TWITCH_TOKEN=""
ENV TWITCH_CHANNEL=""
CMD ["java", "-cp", "target/twitch-java-bot-1.0.jar", "TwitchBot"]
