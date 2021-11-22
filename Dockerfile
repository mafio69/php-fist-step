FROM php:fpm-buster

# https://github.com/php/php-src/blob/17baa87faddc2550def3ae7314236826bc1b1398/sapi/fpm/php-fpm.8.in#L163
# Override stop signal to stop process gracefully
# https://github.com/php/php-src/blob/17baa87faddc2550def3ae7314236826bc1b1398/sapi/fpm/php-fpm.8.in#L163
ENV DEBIAN_FRONTEND=noninteractive \
      APP_ENV=${APP_ENV:-prod} \
      DISPLAY_ERROR=${DISPLAY_ERROR:-off} \
      XDEBUG_MODE=${XDEBUG_MODE:-off} \
      PHP_DATE_TIMEZONE=${PHP_DATE_TIMEZONE:-Europe/Warsaw}
RUN apt update && apt upgrade -y && apt install -y apt-utils \
    && apt install -y lsb-release ca-certificates apt-transport-https software-properties-common \
    && apt install -y wget curl cron git unzip gnupg2 build-essential && apt install -y nginx \
    && apt install -y libicu-dev && apt-get install g++ && rm -rf /tmp/pear \
    && apt -y full-upgrade && apt -y autoremove && ln -s /var/log/nginx/ `2>&1 nginx -V | grep -oP "(?<=--prefix=)\S+"`/logs

RUN docker-php-source extract \
    && pecl install xdebug \
    && pecl install -o -f redis \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable intl \
    && docker-php-source delete \
    && rm -Rf /usr/local/etc/php/conf.d/xdebug.ini

RUN apt-get update && apt-get install -y supervisor && mkdir -p /var/log/supervisor

WORKDIR /

COPY config/custom.ini /usr/local/etc/php/conf.d/custom.ini
COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY config/nginx/mime.types /etc/nginx/mime.types
COPY config/custom.ini /usr/local/etc/php/conf.d/custom.ini
COPY config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY config/nginx/enabled-symfony.conf /etc/nginx/conf.d/enabled-symfony.conf
COPY config/supervisord-main.conf /etc/supervisord.conf
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

STOPSIGNAL SIGQUIT
EXPOSE 8080
CMD ["/usr/bin/supervisord", "-nc", "/etc/supervisord.conf"]