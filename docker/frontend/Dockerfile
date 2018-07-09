ARG NGINX_TAG=1-alpine
FROM nginx:${NGINX_TAG}

ARG GIT_SHA
ARG VERSION
ENV GIT_SHA=${GIT_SHA}
ENV VERSION=${VERSION}

RUN printf "GIT_SHA=${GIT_SHA}\nVERSION=${VERSION}\n" > build.properties

LABEL MAINTAINER="Ryan Blunden <ryan.blunden@rabbitbird.com>"
LABEL NAME="Cats Who Code Front-End"
LABEL VERSION="${VERSION}"

RUN apk update && apk upgrade

COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d /etc/nginx/conf.d/

HEALTHCHECK --interval=5s --timeout=5s --retries=3 CMD wget http://api:8000/health-check/ -q -O - > /dev/null 2>&1

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
