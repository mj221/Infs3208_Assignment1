FROM ubuntu:18.04

MAINTAINER Minjae Lee <m.j.lee@uqconnect.edu.au>

ENV PHPVER 7.4

ENV TZ Australia/Brisbane

RUN apt-get update \
        && apt-get install -y software-properties-common \
        && add-apt-repository ppa:ondrej/php && apt-get update \
        && apt-get install -y nginx php7.4-fpm \
        && echo $TZ > /etc/timezone \
        && chmod -R +x /var/www/html \
        && rm -rf /var/lib/apt/lists/*

COPY $PWD/src/nginx.ini /etc/nginx/sites-available/default

VOLUME /var/www/html
WORKDIR /var/www/html
EXPOSE 80

ENTRYPOINT service php7.4-fpm start && nginx -g "daemon off;"
