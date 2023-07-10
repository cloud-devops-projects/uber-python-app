FROM ubuntu:latest

WORKDIR /app

COPY . /app

# EXPOSE 8080

RUN apt-get update && apt-get upgrade

RUN apt install python3-pip -y

RUN pip install -r requirements.txt

CMD ["python3", "app.py"]