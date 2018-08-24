ARG PYTHON_TAG=3.7-slim
FROM python:${PYTHON_TAG}

ARG GIT_SHA
ARG VERSION
ENV GIT_SHA=${GIT_SHA}
ENV VERSION=${VERSION}

LABEL MAINTAINER="Ryan Blunden <ryan.blunden@rabbitbird.com>"
LABEL NAME="Cats Who Code API"
LABEL VERSION="${VERSION}"

ENV LC_CTYPE=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED 1

RUN printf "GIT_SHA=${GIT_SHA}\nVERSION=${VERSION}\n" > build.properties

RUN apt-get update && \
    apt-get upgrade -y  && \
    apt-get install -y --no-install-recommends curl default-libmysqlclient-dev gcc jq less groff && \
    apt-get clean && \
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

HEALTHCHECK --interval=5s --timeout=5s --retries=3  CMD curl --fail http://localhost${UWSGI_HTTP}/health-check/ || exit 1

EXPOSE 8000

CMD ["uwsgi", "--http-auto-chunked", "--http-keepalive"]
ENTRYPOINT ["./bin/entrypoint.sh"]
