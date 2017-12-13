#!/usr/bin/env bash

docker container stop catswhocode_api
docker container rm catswhocode_api

docker container stop catswhocode_frontend
docker container rm catswhocode_frontend

docker network rm catswhocode_frontend

