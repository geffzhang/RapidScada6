FROM debian:bullseye-slim

WORKDIR /tmp
RUN apt update && apt-get install -y wget unzip
RUN wget https://github.com/geffzhang/RapidScada6/blob/main/rapidscada.zip && unzip rapidscada.zip
