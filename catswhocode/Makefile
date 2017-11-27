stack:
	docker-compose up ${ARGS}

stack-dev:
	docker-compose -f docker-compose.yml -f docker-compose-dev.yml up ${ARGS}

api-bash:
	docker exec -it catswhocode_api bash

api-create-superuser:
	docker exec -it catswhocode_api ./manage.py createsuperuser

stack-stop:
	docker-compose stop
