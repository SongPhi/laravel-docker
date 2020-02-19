#!/bin/sh

php artisan migrate

php artisan serve --port=$PORT --host="0.0.0.0" -n