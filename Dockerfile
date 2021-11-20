FROM php:8.0.12-fpm

RUN apt update && apt upgrade -y && apt install -y lsb-release ca-certificates apt-transport-https software-properties-common \
    &&  apt install -y wget curl cron git unzip gnupg2 build-essential && apt install -y nginx
RUN apt -y full-upgrade && apt -y autoremove && ln -s /var/log/nginx/ `2>&1 nginx -V | grep -oP "(?<=--prefix=)\S+"`/logs
RUN wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add -

RUN apt -y full-upgrade && apt -y autoremove
WORKDIR /
STOPSIGNAL SIGQUIT

EXPOSE 9000
CMD ["php-fpm"]