# Используем доступный образ OpenJDK от Eclipse Temurin
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Копируем проект
COPY . .

# Сборка проекта через Maven
RUN ./mvnw clean package || mvn clean package

# Переменные окружения (Render их заменит)
ENV TWITCH_TOKEN=""
ENV TWITCH_CHANNEL=""

# Запуск бота
CMD ["java", "-cp", "target/twitch-java-bot-1.0.jar", "TwitchBot"]
