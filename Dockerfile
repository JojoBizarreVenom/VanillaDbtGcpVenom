FROM python:3.12.5

WORKDIR /app
COPY /app/ /app/
COPY requirements.txt /app/

RUN pip3 install -r requirements.txt

EXPOSE 8080
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]