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
