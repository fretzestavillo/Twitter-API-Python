# Use an official Python image as a parent image
FROM python:3.10-slim

WORKDIR /app

COPY  app.py requirements.txt ./


RUN pip install --no-cache-dir -r requirements.txt


CMD ["python3", "/app/app.py"]




