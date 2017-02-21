FROM library/php:5-apache

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN DEBIAN_FRONTEND=noninteractive \
    echo "Acquire::http::Proxy \"$http_proxy\";" >> /etc/apt/apt.conf && \
    apt-get update && \
    apt-get install -y build-essential && \
    apt-get install -y software-properties-common && \
    apt-get install -y gettext-base python-software-properties python g++ make && \
    apt-get install -y git vim curl wget libcurl4-gnutls-dev libxml2-dev libssh2-1-dev libjpeg62-turbo-dev libpng12-dev && \
    docker-php-ext-install -j$(nproc) gd curl soap mysql pdo pdo_mysql && \
    apt-get -y install snmp && \
    apt-get clean && \
    pecl install ssh2 && \
    docker-php-ext-enable ssh2 && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

