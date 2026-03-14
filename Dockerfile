# Используем стабильный образ с JDK 17
FROM openjdk:17-jdk-slim

WORKDIR /app

# Копируем весь проект
COPY . .

# Сборка проекта
RUN ./mvnw clean package || mvn clean package

# Переменные окружения (будут заданы на Render)
ENV TWITCH_TOKEN=""
ENV TWITCH_CHANNEL=""

# Запуск бота
CMD ["java", "-cp", "target/twitch-java-bot-1.0.jar", "TwitchBot"]
