FROM alpine:3.9

RUN apk upgrade --update --no-cache

RUN apk add bash wget unzip ca-certificates git \
    php7 php7-gd php7-zlib php7-curl php7-mcrypt php7-pgsql \
    php7-intl php7-mbstring php7-pdo_pgsql php7-pear php7-phar php7-zip \
    php7-xml php7-xsl php7-json php7-simplexml php7-tokenizer \
    php7-xmlwriter php7-fileinfo php7-ctype php7-xmlreader php7-session \
    ttf-liberation unifont openssl php7-pecl-apcu php7-opcache \
    php7-pecl-redis redis composer gettext php7-pecl-yaml php7-pdo_mysql \
    php7-fpm nginx supervisor

# update font cache
RUN fc-cache -f

ADD artisan.local /usr/local/bin/artisan
ADD docker-entrypoint.sh /

RUN mkdir -p /srv/www

WORKDIR /srv/www

COPY ./composer.json /srv/www/
COPY ./composer.lock /srv/www/


COPY ./config/supervisord.conf /etc/supervisord.conf
COPY ./config/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf

# clean up, reduce image size
RUN rm -rf /var/cache/apk/*

RUN mkdir -p /run/nginx && chown nginx:nginx /run/nginx

RUN chown nginx:nginx /srv/www
RUN chmod +x /srv

RUN composer install --no-autoloader --no-scripts --no-progress --no-suggest

EXPOSE 8000

CMD ["cmd"]
ENTRYPOINT ["/docker-entrypoint.sh"]
