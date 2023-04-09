FROM php:8-fpm

RUN apt-get update && apt-get install -y nginx supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY default.conf /etc/nginx/nginx.conf

COPY ./src /var/www/html/
WORKDIR /var/www/html

EXPOSE 80
EXPOSE 7001

COPY start-container /usr/local/bin/start-container
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY php.ini /usr/local/etc/php/conf.d/php.ini
RUN chmod +x /usr/local/bin/start-container

ENTRYPOINT [ "start-container" ]
