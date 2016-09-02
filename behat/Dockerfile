FROM ubuntu:xenial

MAINTAINER web-tech <web-tech@20minutes.fr>

# Install Java
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y -q software-properties-common \
    && add-apt-repository ppa:openjdk-r/ppa \
    && apt-get update && apt-get install -y -q openjdk-8-jre-headless

# Install Xvfb firefox php
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
    xvfb \
    firefox \
    php \
    php-cli \
    php-intl \
    php-curl \
    php-redis \
    php-xml

ENV DISPLAY=:99.0 _JAVA_OPTIONS="-Xms2048m -Xmx2048m"

# Set php.ini
RUN sed -i 's/;date.timezone =/date.timezone = "Europe\/Paris"/g' /etc/php/7.0/cli/php.ini
RUN echo "127.0.0.1 assets-m.20mn.fr" >> /etc/hosts

COPY ["./start.sh", "/start.sh"]
RUN chmod 744 /start.sh

CMD ["/start.sh"]
