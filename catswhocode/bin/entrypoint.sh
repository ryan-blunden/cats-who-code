#!/bin/bash

set -e

./bin/wait-for-it.sh db:3306 -- echo "MySQL is up"

./bin/wait-for-it.sh cache:6379 -- echo "Redis is up"

if [ "x$DJANGO_MANAGEPY_MIGRATE" = 'xon' ]; then
    ./manage.py migrate --noinput
Fi

if [ "x$DJANGO_MANAGEPY_COLLECTSTATIC" = 'xon' ]; then
    ./manage.py collectstatic --noinput
fi

exec "$@"


# Prepare log files and start outputting logs to stdout
mkdir -p /usr/src/app/logs
touch /usr/src/app/logs/gunicorn.log
touch /usr/src/app/logs/access.log
touch /usr/src/app/logs/error.log
tail -n 0 -f /usr/src/app/logs/*.log &

# Start Gunicorn processes
echo Starting Gunicorn.
exec gunicorn ${WSGI_APP} \
    --name ${WSGI_APP_NAME} \
    --bind 0.0.0.0:${WSGI_APP_PORT} \
    --workers 2 \
    --log-level=info \
    --log-file=/usr/src/app/logs/gunicorn.log \
    --access-logfile=/usr/src/app/logs/access.log \
    --access-logfile=/usr/src/app/logs/error.log \
    "$@"
