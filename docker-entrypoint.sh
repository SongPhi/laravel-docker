#!/bin/sh

php artisan migrate

ln -s /srv/www/storage/app/public /srv/www/public/storage

chown nginx:nginx /srv/www/storage
chown nginx:nginx /srv/www/storage/app
chown nginx:nginx /srv/www/storage/app/public


chown nginx:nginx -R /srv/www/storage/app/db-blade-compiler
chown nginx:nginx -R /srv/www/storage/debugbar
chown nginx:nginx -R /srv/www/storage/framework
chown nginx:nginx -R /srv/www/storage/logs


echo "Starting up.."

supervisord -c /etc/supervisord.conf
