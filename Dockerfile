# Используем доступный образ OpenJDK 17
FROM openjdk:17

WORKDIR /app

# Копируем весь проект
COPY . .

# Сборка проекта
RUN ./mvnw clean package || mvn clean package

# Переменные окружения
ENV TWITCH_TOKEN=""
ENV TWITCH_CHANNEL=""

# Запуск бота
CMD ["java", "-cp", "target/twitch-java-bot-1.0.jar", "TwitchBot"]
