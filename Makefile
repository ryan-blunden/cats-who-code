SHELL := /bin/bash

#---------------------------------
# DOCKER COMPOSE RUN COMMANDS
# For running the stack on a single machine, either locally (make stack-dev-start) or remote (make stack).
#---------------------------------

# TODO: Has to be a better way to remove files across Windows and *nix.
# See https://stackoverflow.com/questions/4058840/makefile-that-distincts-between-windows-and-unix-like-systems

clean:
	- @rm -f Pipfile.lock
	- @rm -f docs/Pipfile.lock
	- @rm -f app/Pipfile.lock

	- @del Pipfile.lock
	- @del docs/Pipfile.lock
	- @del app/Pipfile.lock

build: clean
	docker-compose build ${ARGS}

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
