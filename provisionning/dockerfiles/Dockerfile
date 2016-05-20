FROM php:5.5-apache
COPY addedFiles/php.ini /usr/local/etc/php/

RUN apt-get update && apt-get install -y g++ libpng12-dev libicu-dev libcurl4-gnutls-dev\
    && docker-php-ext-configure curl --with-curl \
    && docker-php-ext-install -j$(nproc) intl curl mbstring mysql pdo_mysql gd\
    && pecl install apcu redis cli xdebug \
    && docker-php-ext-enable curl intl redis xdebug mbstring mysql pdo_mysql gd\
    && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini\
    && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

RUN apt-get -y --force-yes install supervisor
RUN apt-get install locate

WORKDIR /var/www/html
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN a2enmod php5
RUN a2enmod rewrite
RUN a2enmod headers

VOLUME ["/commands"]
VOLUME ["/vhosts"]

