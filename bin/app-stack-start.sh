#!/usr/bin/env bash

#docker network ls -f name=catswhocode_frontend
#RESULT=$?
#if [ $RESULT -gt 0 ]; then
#    docker network create catswhocode_frontend;
#fi

docker network create catswhocode_frontend

docker container run \
    --detach \
    --env-file app/app.prod.env \
    --init \
    --volume ${PWD}/app/app.prod.env:/usr/src/app/app/app.prod.env \
    --network catswhocode_frontend \
    --network-alias api \
    --hostname api \
    --name catswhocode_api \
    --restart on-failure \
    catswhocode/api

docker container run \
    --detach \
    --network catswhocode_frontend \
    --name catswhocode_frontend \
    --restart on-failure \
    --publish 80:8000 \
    catswhocode/frontend
