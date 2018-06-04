FROM python:3.6.5-slim

ENV LC_CTYPE=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED 1

HEALTHCHECK CMD curl --fail http://localhost${UWSGI_HTTP}/health-check/ || exit 1

RUN apt-get update && \
    apt-get upgrade -y  && \
    apt-get install -y --no-install-recommends curl libmysqlclient-dev gcc jq less groff && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

RUN pip install pip setuptools --upgrade && \
    pip install pipenv && \
    ln -s /usr/local/bin/python /bin/python && \
    printf "\ncomplete -C '/usr/local/bin/aws_completer' aws" >> /root/.bashrc

COPY app/requirements-production.txt app/requirements-development.txt ./
RUN pip install -r requirements-production.txt

COPY app .

# uWSGI
ENV UWSGI_WSGI_FILE=catswhocode/wsgi.py
ENV UWSGI_HTTP=:8000
ENV UWSGI_MASTER=1
ENV UWSGI_WORKERS=2
ENV UWSGI_THREADS=8
ENV UWSGI_LAZY_APPS=1
ENV UWSGI_WSGI_ENV_BEHAVIOR=holy

EXPOSE 8000

CMD ["uwsgi", "--http-auto-chunked", "--http-keepalive"]
ENTRYPOINT ["./bin/entrypoint.sh"]
