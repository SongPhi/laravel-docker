FROM alpine:3.11

RUN apk upgrade --update --no-cache

RUN apk add bash wget unzip ca-certificates git \
    php7 php7-gd php7-zlib php7-curl php7-mcrypt php7-pgsql \
    php7-intl php7-mbstring php7-pdo_pgsql php7-pear php7-phar php7-zip \
    php7-xml php7-xsl php7-json php7-simplexml php7-tokenizer \
    php7-xmlwriter php7-fileinfo php7-ctype php7-xmlreader php7-session \
    ttf-liberation unifont openssl php7-pecl-apcu php7-opcache \
    php7-pecl-redis redis composer gettext php7-pecl-yaml php7-pdo_mysql \
    php7-fpm nginx supervisor

# clean up, reduce image size
RUN rm -rf /var/cache/apk/*

# update font cache
RUN fc-cache -f

RUN composer global config repositories.0 composer https://packagist.songphi.org
RUN echo '{"http-basic":{"packagist.songphi.org":{"username":"songphi","password":"2014"}}}' > ~/.composer/auth.json

RUN composer global require hirak/prestissimo

RUN mkdir -p /srv/www

WORKDIR /srv/www

RUN cd /srv && composer create-project --prefer-dist laravel/laravel www

ADD artisan.local /usr/local/bin/artisan
ADD docker-entrypoint.sh /

EXPOSE 8000

CMD ["cmd"]
ENTRYPOINT ["/docker-entrypoint.sh"]
