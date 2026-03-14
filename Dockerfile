# Берём официальный образ с JDK 20
FROM openjdk:17-jdk

# Создаём рабочую папку
WORKDIR /app

# Копируем все файлы проекта в контейнер
COPY . .

# Сборка проекта через Maven
RUN ./mvnw clean package || mvn clean package

# Переменные окружения будут заданы на сервере
ENV TWITCH_TOKEN=""
ENV TWITCH_CHANNEL=""

# Команда для запуска бота
CMD ["java", "-cp", "target/twitch-java-bot-1.0.jar", "TwitchBot"]
