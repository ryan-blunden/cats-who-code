stack:
	docker-compose up ${ARGS}

stack-dev:
	docker-compose -f docker-compose.yml -f docker-compose-dev.yml up ${ARGS}

stack-stop:
	docker-compose stop
