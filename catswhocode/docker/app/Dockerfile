FROM python:3.6.3-slim

ENV LC_CTYPE=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED 1

ENV DJANGO_SETTINGS_MODULE=catswhocode.settings
ENV DJANGO_SECRET_KEY=''

ENV DJANGO_MANAGEPY_MIGRATE=''
ENV DJANGO_MANAGEPY_COLLECTSTATIC=''

# DB (MySQL)
ENV DB_NAME=''
ENV DB_USER=''
ENV DB_PASSWORD=''
ENV DB_HOST='db'
ENV DB_PORT='3306'

# uWSGI
ENV UWSGI_WSGI_FILE=catswhocode/wsgi.py
ENV UWSGI_HTTP=:8000
ENV UWSGI_MASTER=1
ENV UWSGI_WORKERS=2
ENV UWSGI_THREADS=8
ENV UWSGI_UID=1000
ENV UWSGI_GID=2000
ENV UWSGI_LAZY_APPS=1
ENV UWSGI_WSGI_ENV_BEHAVIOR=holy

HEALTHCHECK CMD curl --fail http://localhost${UWSGI_HTTP}/health-check/ || exit 1

RUN apt-get update && \
    apt-get upgrade -y  && \
    apt-get install -y --no-install-recommends curl make nano libmysqlclient-dev gcc && \
    \
    apt-get clean -y && \
    apt-get purge -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    \
    rm -rf /usr/share/locale/* && \
    rm -rf /var/cache/debconf/*-old && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

WORKDIR /usr/src/app

#
## PYTHON DEPENDENCIES
#
RUN pip install pip setuptools --upgrade
RUN pip install pipenv
RUN ln -s /usr/local/bin/python /bin/python

COPY cats catswhocode manage.py Pipfile ./
RUN pipenv install --deploy --system
RUN apt-get remove libmysqlclient-dev gcc -y

EXPOSE 8000

CMD ["uwsgi", "--http-auto-chunked", "--http-keepalive"]
ENTRYPOINT ["./bin/entrypoint.sh"]
