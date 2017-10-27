#!/bin/bash

set -e

./bin/wait-for-it.sh db:3306 -- echo '[info]: MySQL is up.'

./bin/wait-for-it.sh cache:6379 -- echo '[info]: Redis is up.'

if [ "x$DJANGO_DEBUG" = 'xon' ]; then
    echo '[info]: Installing development packages as DJANGO_DEBUG is set.'
    pipenv install --dev
fi

if [ "x$DJANGO_MANAGEPY_MIGRATE" = 'xon' ]; then
    ./manage.py migrate --noinput
fi

if [ "x$DJANGO_MANAGEPY_COLLECTSTATIC" = 'xon' ]; then
    ./manage.py collectstatic --noinput
fi

exec "$@"
