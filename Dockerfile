FROM eclipse-temurin:17-jdk

WORKDIR /app

# Устанавливаем Maven
RUN apt-get update && apt-get install -y maven

# Копируем проект
COPY . .

# Сборка проекта через Maven
RUN mvn clean package

# Переменные окружения (Render их заменит)
ENV TWITCH_TOKEN=""
ENV TWITCH_CHANNEL=""

# Запуск бота
CMD ["java", "-cp", "target/twitch-java-bot-1.0.jar", "TwitchBot"]
