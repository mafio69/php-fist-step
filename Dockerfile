FROM php:fpm-buster
MAINTAINER mf1969@gmail.com mafio

ENV DEBIAN_FRONTEND=noninteractive \
    PHP_DATE_TIMEZONE=${PHP_DATE_TIMEZONE:-Europe/Warsaw} \
    SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.12/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=048b95b48b708983effb2e5c935a1ef8483d9e3e \
    XDEBUG_REMOTE_AUTOSTART=${XDEBUG_REMOTE_AUTOSTART:-1} \
    XDEBUG_CLIENT_PORT=${XDEBUG_CLIENT_PORT:-9003} \
    XDEBUG_CLIENT_HOST=${XDEBUG_CLIENT_HOST:-172.18.0.1} \
    XDEBUG_MODE=${XDEBUG_MODE:-off} \
    APP_DEBUG=${APP_DEBUG:-0} \
    APP_ENV=${APP_ENV:-prod} \
    DISPLAY_ERROR=${DISPLAY_ERROR:-off} \
    # https://www.php.net/manual/en/timezones.php
    PHP_DATE_TIMEZONE=${PHP_DATE_TIMEZONE:-Europe/Warsaw}

RUN apt-get update && apt-get install -y gnupg2 \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62 \
    && apt update && apt upgrade -y && apt install -y apt-utils \
    && apt install -y lsb-release ca-certificates apt-transport-https software-properties-common \
    && apt install -y wget curl cron git unzip gnupg2 build-essential \
    && apt install -y libicu-dev && apt-get install g++ && rm -rf /tmp/pear \
    && apt -y full-upgrade && apt -y autoremove && ln -s /var/log/nginx/ `2>&1 nginx -V | grep -oP "(?<=--prefix=)\S+"`/logs \
    && apt-get update && apt-get install -y supervisor && mkdir -p /var/log/supervisor && apt-get -y install nginx \
    && apt-get install -y libzip-dev zip \
    && docker-php-source extract \
    && pecl install xdebug \
    && pecl install -o -f redis \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-configure sockets \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install zip \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable intl \
    && docker-php-source delete \
    && rm -Rf /usr/local/etc/php/conf.d/xdebug.ini \
    && rm -f /etc/supervisor/supervisord.conf \
    && rm -f /usr/local/etc/php/conf.d/docker-php-ext-zip.ini \
    && mkdir -p /usr/share/nginx/logs && touch /usr/share/nginx/logs/error.log

RUN curl -fsSLO "$SUPERCRONIC_URL" \
    && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
    && chmod +x "$SUPERCRONIC" \
    && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
    && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic \
    && curl -sS https://getcomposer.org/installer | php \
    && mkdir -p /usr/share/nginx/logs/ \
    && touch -c /usr/share/nginx/logs/error.log \
    && mkdir -p /usr/share/nginx/logs/ \
    && cp composer.phar /usr/local/bin/composer  \
    && mv composer.phar /usr/bin/composer \
    && addgroup docker

WORKDIR /

COPY config/php.ini /usr/local/etc/php/php.ini
COPY config/custom.ini /usr/local/etc/php/conf.d/custom.ini
COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY config/nginx/mime.types /etc/nginx/mime.types
COPY config/nginx/enabled-app.conf /etc/nginx/conf.d/enabled-app.conf
COPY config/supervisord-main.conf /etc/supervisord.conf
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

STOPSIGNAL SIGQUIT
EXPOSE 8080
CMD ["/usr/bin/supervisord", "-nc", "/etc/supervisord.conf"]