SHELL := /bin/bash

#-----------------------------------------------------------------------------------------------------------------------
# DOCKER COMPOSE RUN COMMANDS
# For running the stack on a single machine, either locally (make stack-dev) or remote (make stack).
#-----------------------------------------------------------------------------------------------------------------------

stack-clean:
	@rm -f Pipfile.lock
	@rm -f docs/Pipfile.lock
	@rm -f app/Pipfile.lock

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

awscli: stack-build
	docker container run --rm -it -v $(CURDIR)/automation:/usr/src/app/automation catswhocode/awscli

# TODO: Command for running front-end and api - NOT YET WORKING
# NOTE: It's presumed that the host will a env file at cats-who-code/app/app.prod.env
app-stack:
	# Networking
	if docker network ls -f name=catswhocode_frontend return code is not 0
		docker network create catswhocode_frontend
	fi

	# API
	docker container run \
		--detach \
		--env-file app/app.prod.env \
		--init \
		--volume $(CURDIR)/app/app.prod.env /usr/src/app/app/app.prod.env \
		--network catswhocode_frontend \
		--hostname api \
		--name catswhocode_api \
		--restart on-failure \
		catswhocode/api

	# FRONT-END
	docker container run \
		--detach \
		--network catswhocode_frontend \
		--name catswhocode_frontend \
		--restart on-failure \
		--publish list 80:8080 \
		catswhocode/frontend
