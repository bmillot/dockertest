FROM debian:jessie

MAINTAINER Bertrand Millot <bmillot@20minutes.fr>

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y -q apache2 php5 libapache2-mod-php5 php5-intl php5-curl php5-mysql php5-redis

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2", "-DFOREGROUND"]
