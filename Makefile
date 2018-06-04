SHELL := /bin/bash

#---------------------------------
# DOCKER COMPOSE RUN COMMANDS
# For running the stack on a single machine, either locally (make stack-dev-start) or remote (make stack).
#---------------------------------

build:
	docker-compose build ${ARGS}

check:
	docker pull projectatomic/dockerfile-lint:latest
	docker container run -it --rm --privileged \
	-v "$(CURDIR)":/root/ \
	-v "$(CURDIR)/docker":/usr/src/app/docker \
	projectatomic/dockerfile-lint:latest dockerfile_lint \
	-f /usr/src/app/docker/api/Dockerfile \
	-f /usr/src/app/docker/frontend/Dockerfile \
	-f /usr/src/app/docker/docs/Dockerfile


################
## Dev Server ##
################
#
# Runs all required services in Docker, plus the docs, mail server and portainer.
#

app-dev-start:
	docker-compose -f docker-compose.yml -f docker-compose-dev.yml up ${ARGS}

app-dev-stop:
	docker-compose -f docker-compose.yml -f docker-compose-dev.yml stop

#######################
## Production Server ##
#######################
#
# Only starts the front-end and application server
#

app-start:
	docker-compose up ${ARGS}

app-stop:
	docker-compose stop
