# Используйте более стабильную версию Alpine
FROM python:3.9-alpine3.19

WORKDIR /app

# Установка build-зависимостей для некоторых Python-пакетов
RUN apk add --no-cache --virtual .build-deps gcc musl-dev && \
    pip install --no-cache-dir flask flask-sqlalchemy && \
    apk del .build-deps

# Копирование файлов приложения (после установки зависимостей для кэширования)
COPY . .

# Убедитесь, что файл app.py существует
RUN ls -la && test -f app.py || (echo "app.py not found" && exit 1)

EXPOSE 5000
CMD ["python", "app.py"]