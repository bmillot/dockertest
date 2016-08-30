FROM ubuntu:xenial

MAINTAINER web-tech <web-tech@20minutes.fr>

# Install wget & java xvfb firefox php
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y -q software-properties-common \
    && add-apt-repository ppa:openjdk-r/ppa && apt-get update \
    && apt-get install -y -q openjdk-8-jre-headless xvfb firefox redis-server \
    && apt-get install -y -q php php-cli php-intl php-curl php-redis php-xml

COPY ["./start.sh", "/start.sh"]

RUN chmod 777 /start.sh

CMD ["/start.sh"]
