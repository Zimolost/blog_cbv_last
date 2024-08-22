# Используем минимальный образ на основе Alpine Linux
FROM python:3.12.0-alpine

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Переменные окружения для предотвращения создания pyc-файлов и буферизации
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Устанавливаем зависимости для компиляции и работы с базой данных
RUN apk add --no-cache gcc musl-dev libffi-dev \
    && apk add --no-cache postgresql-dev  # или другие зависимости, нужные для базы данных

# Устанавливаем Python-зависимости
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь код проекта в рабочую директорию
COPY . /app/

# Открываем порт 8000
EXPOSE 8000

# Команда для запуска приложения
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "blog_cbv.wsgi:application"]
