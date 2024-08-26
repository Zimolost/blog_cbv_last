
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt /app/

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем проект в контейнер
COPY . /app/

# Создаем директорию для статических файлов
RUN mkdir -p /app/staticfiles && \
    chmod 755 /app/staticfiles

# Собираем статические файлы
RUN python manage.py collectstatic --noinput

RUN chown -R root:root /app/staticfiles

# Открываем порт для Django
EXPOSE 8001

# Запускаем сервер Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
