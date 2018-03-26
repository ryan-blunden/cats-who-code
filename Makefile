SHELL := /bin/bash

#-----------------------------------------------------------------------------------------------------------------------
# DOCKER COMPOSE RUN COMMANDS
# For running the stack on a single machine, either locally (make stack-dev) or remote (make stack).
#-----------------------------------------------------------------------------------------------------------------------

# TODO: Has to be a better way to remove files across Windows and *nix.
# See https://stackoverflow.com/questions/4058840/makefile-that-distincts-between-windows-and-unix-like-systems
stack-clean:
	- @rm -f Pipfile.lock
	- @rm -f docs/Pipfile.lock
	- @rm -f app/Pipfile.lock

	- @del Pipfile.lock
	- @del docs/Pipfile.lock
	- @del app/Pipfile.lock

stack-build: stack-clean
	docker-compose build ${ARGS}

stack: stack-clean
	docker-compose up ${ARGS}

stack-dev: stack-clean
	docker-compose -f docker-compose.yml -f docker-compose-dev.yml up ${ARGS}

stack-stop:
	docker-compose stop

#-----------------------------------------------------------------------------------------------------------------------
# STANDALONE CONTAINER RUN COMMANDS
# For running containers without Docker Compose for when we deploy the app, MySQL ad Redis to different instances.
#-----------------------------------------------------------------------------------------------------------------------

app-stack-start:
	docker network create catswhocode_frontend

	docker container run \
		--detach \
		--env-file $(CURDIR)/app/app.prod.env \
		--init \
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
		--publish 80:8080 \
		catswhocode/frontend

app-stack-stop:
	-docker container stop catswhocode_api
	-docker container rm catswhocode_api

	-docker container stop catswhocode_frontend
	-docker container rm catswhocode_frontend

	-docker network rm catswhocode_frontend
