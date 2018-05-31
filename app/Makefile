APP_CONTAINER=catswhocode_api


################################
##  APP CONTAINER OPERATIONS  ##
################################

shell:
	docker container exec -it $(APP_CONTAINER) bash

restart:
	docker container restart $(APP_CONTAINER)

health-check:
	@curl -H "Accept: application/json" http://localhost:8080/health-check/
	@echo ""


#####################
##  DB OPERATIONS  ##
#####################

db-create-dev:
	docker container exec -it catswhocode_db bash -c 'echo "CREATE DATABASE catswhocode CHARACTER SET utf8 COLLATE utf8_bin;" | mysql -u root'
	$(MAKE) restart

db-destroy-dev:
	docker container exec -it catswhocode_db bash -c 'echo "DROP DATABASE catswhocode;" | mysql -u root'


################################
##  S3 DEV SERVER OPERATIONS  ##
################################

bucket-create-dev:
	docker container run \
		--rm \
		--network=cats-who-code_backend \
		--entrypoint=/bin/sh \
		minio/mc -c '\
			mc config host add s3 http://s3:9000 JZ2ACMY43EXTMVWVOYZD 7Xn9y+YKQdJ2azRR2QmKDqa9ksa4zfwGcyjq/saS && \
			mc mb s3/cats-who-code && \
			mc policy download s3/cats-who-code \
		'
		$(MAKE) restart


#############################
##  DJANGO APP OPERATIONS  ##
#############################

superuser:
	docker container exec -it $(APP_CONTAINER) ./manage.py createsuperuser

migrations:
	docker container exec -it $(APP_CONTAINER) ./manage.py makemigrations

migrate:
	docker container exec -it $(APP_CONTAINER) ./manage.py migrate --noinput


#################
##  UTILITIES  ##
#################

lint:
	flake8 ./ \
	    --exclude=migrations,.git,static,data,fixtures,*.json,templates \
	    --max-complexity 12 \
	    --ignore=E501
