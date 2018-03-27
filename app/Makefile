APP_CONTAINER=catswhocode_api

shell:
	docker container exec -it $(APP_CONTAINER) bash

db-create-dev:
	docker container exec -it catswhocode_db bash -c 'echo "CREATE DATABASE catswhocode CHARACTER SET utf8 COLLATE utf8_bin;" | mysql -u root'
	$(MAKE) restart

db-destroy-dev:
	docker container exec -it catswhocode_db bash -c 'echo "DROP DATABASE catswhocode;" | mysql -u root'

superuser:
	docker container exec -it $(APP_CONTAINER) ./manage.py createsuperuser

migrations:
	docker container exec -it $(APP_CONTAINER) ./manage.py makemigrations

migrate:
	docker container exec -it $(APP_CONTAINER) ./manage.py migrate --noinput

restart:
	docker container restart $(APP_CONTAINER)

healthcheck:
	@curl -H "Accept: application/json" http://localhost:8080/health-check/
	@echo ""

lint:
	flake8 ./ \
	    --exclude=migrations,.git,static,data,fixtures,*.json,templates \
	    --max-complexity 12 \
	    --ignore=E501
