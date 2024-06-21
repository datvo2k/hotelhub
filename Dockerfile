FROM python:alpine3.12

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1 

RUN apk update && apk upgrade
RUN pip install --upgrade pip
RUN apk add sqlite

WORKDIR /app

RUN pip install --no-cache-dir Django

COPY . /app/

EXPOSE 8000

RUN python manage.py makemigrations
RUN python manage.py migrate
RUN python manage.py migrate --run-syncdb
CMD python manage.py runserver 0.0.0.0:8000