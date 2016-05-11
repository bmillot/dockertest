FROM debian:jessie

MAINTAINER Bertrand Millot <bmillot@20minutes.fr>

# Install Apache 2.4 & PHP7
RUN apt-get update && apt-get install -y -q wget \
    && echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && wget https://www.dotdeb.org/dotdeb.gpg \
    && apt-key add dotdeb.gpg && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y -q apache2 php7.0 libapache2-mod-php7.0 php7.0-intl php7.0-curl php7.0-mysql php7.0-redis

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2", "-DFOREGROUND"]
