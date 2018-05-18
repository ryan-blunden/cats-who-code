FROM python:3.6-slim

RUN apt-get update && \
    apt-get upgrade -y  && \
    apt-get install -y --no-install-recommends make nano patch && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app


#
## PYTHON DEPENDENCIES
#

# Temporary workaround for mkdocs install failure. - https://github.com/kennethreitz/pipenv/issues/955
RUN ln -s /usr/local/bin/python /bin/python

COPY ./docs .

RUN pip install pip setuptools --upgrade && \
    pip install -r requirements.txt

#
## MKDOCS
#

EXPOSE 8000

CMD ["mkdocs", "serve", "--dev-addr=0.0.0.0:8000"]
