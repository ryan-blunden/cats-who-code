SHELL := /bin/bash

#############
##  Build  ##
#############

docker-images-build:
	docker image pull nginx:1-alpine 
	docker image pull python:3.6.5-slim

	cd /tmp && \
	rm -fr learn-docker && \
    git clone https://github.com/ryan-blunden/learn-docker && \
    cd learn-docker/mkdocs && \
	"$(MAKE)" docker-build && \
    cd /tmp && \
    rm -fr learn-docker

build: docker-images-build
	docker-compose build ${ARGS}

check:
	docker pull projectatomic/dockerfile-lint:latest
	docker container run -it --rm --privileged \
	-v "$(CURDIR)":/root/ \
	-v "$(CURDIR)/docker":/usr/src/app/docker \
	projectatomic/dockerfile-lint:latest dockerfile_lint \
	-f /usr/src/app/docker/api/Dockerfile \
	-f /usr/src/app/docker/frontend/Dockerfile \

##################
##  Dev Server  ##
##################
#
# Runs all required services in Docker, plus the docs, mail server and portainer.
#

app-dev-start:
	docker-compose -f docker-compose.yml -f docker-compose-dev.yml up ${ARGS}

app-dev-stop:
	docker-compose -f docker-compose.yml -f docker-compose-dev.yml stop

#########################
##  Production Server  ##
#########################
#
# Only starts the front-end and application server
#

app-start:
	docker-compose up ${ARGS}

app-stop:
	docker-compose stop


##########
##  CI  ##
##########

API_IMAGE=catswhocode/api
FRONTEND_IMAGE=catswhocode/frontend

BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)
COMMIT_SHA=$(shell git rev-parse --short HEAD)

build-front-end:
	docker image build \
		--build-arg GIT_BRANCH=$(BRANCH) \
		--build-arg GIT_SHA=$(COMMIT_SHA) \
		--build-arg VERSION=$(COMMIT_SHA) \
		-t $(FRONTEND_IMAGE):latest \
		-t $(FRONTEND_IMAGE):$(COMMIT_SHA) \
		./docker/frontend

build-api:
	docker image build \
		--build-arg GIT_BRANCH=$(BRANCH) \
		--build-arg GIT_SHA=$(COMMIT_SHA) \
		--build-arg VERSION=$(COMMIT_SHA) \
		-t $(API_IMAGE):latest \
		-t $(API_IMAGE):$(COMMIT_SHA) \
		-f docker/api/Dockerfile \
		.

build: build-front-end build-api

docker-lint:
	docker container run -it --rm --privileged \
	-v "$(CURDIR)":/root/ \
	-v "$(CURDIR)/docker":/usr/src/app/docker \
	projectatomic/dockerfile-lint:latest dockerfile_lint \
	-f $(DOCKERFILE)

validate:
	"$(MAKE)" docker-lint DOCKERFILE=/usr/src/app/docker/api/Dockerfile
	"$(MAKE)" docker-lint DOCKERFILE=/usr/src/app/docker/frontend/Dockerfile
	"$(MAKE)" docker-lint DOCKERFILE=/usr/src/app/docker/docs/Dockerfile

test:
	# TODO - Implement tests

artifact:
