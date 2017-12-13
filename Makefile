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

app-stack-start:
	./bin/app-stack-start.sh

app-stack-stop:
	./bin/app-stack-stop.sh
