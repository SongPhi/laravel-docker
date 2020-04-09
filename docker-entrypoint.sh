#!/bin/sh

php artisan migrate

echo "Starting up.."

supervisord -c /etc/supervisord.conf
