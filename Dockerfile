FROM alpine:3.9

RUN apk upgrade --update --no-cache

RUN apk add bash wget unzip ca-certificates git \
    php7 php7-gd php7-zlib php7-curl php7-mcrypt php7-pgsql \
    php7-intl php7-mbstring php7-pdo_pgsql php7-pear php7-phar php7-zip \
    php7-xml php7-xsl php7-json php7-simplexml php7-tokenizer \
    php7-xmlwriter php7-fileinfo php7-ctype php7-xmlreader php7-session \
    ttf-liberation unifont openssl php7-pecl-apcu php7-opcache \
    php7-pecl-redis redis composer gettext

RUN update-ms-fonts && fc-cache -f

ADD artisan.local /usr/local/bin/artisan

WORKDIR /srv/www

EXPOSE 8000

CMD ["cmd"]
ENTRYPOINT ["/docker-entrypoint.sh"]
