# Running the App Locally

## Bringing up the stack

From the project root, change into the `catswhocode` directory and run
 
    make stack-dev ARGS=--build

This will build the local Docker images and run the containers using Docker Compose.

Once the stack has finished coming up, ensure the app is receiving requests by going to [http://localhost:8080](http://localhost:8080).

The app is not yet in a healthy state as the MySQL database has not been created. You'll see an error something like `django.db.utils.OperationalError: (1049, "Unknown database 'catswhocode'")` so so lets continue.

## Initializing the MySQL database

From the project root, change into the `catswhocode/catswhocode` (The Django application directory).

Then setup the MySQL database that Django uses by running the following commands:

    make db-create-dev
    make migrate    

## Health Check

The health check should return all systems normal. [http://localhost:8080/health-check/](http://localhost:8080/health-check/).

# The final test - Login to the admin

First, create a `superuser` account by running the following command:

    make superuser

Visit [http://localhost:8080/manage/](http://localhost:8080/manage/) using the details you entered. 

## Index of Services 

Here is a list of services that are available:

- Python App server (served by NGINX): [http://localhost:8080/](http://localhost:8080/).
- Docs: [http://localhost:3000/](http://localhost:3000/).
- Amazon Linux Container: For using the AWS CLI.
- DynamoDB Shell: [http://localhost:8000/](http://localhost:8000/).
- MySQL: 127.0.0.1 on port 3306.
- Portainer (Container management GUI): [http://localhost:9000/](http://localhost:9000/).

There are other services (e.g. mock mail server and redis) that have a dynamic host port bound. Use `docker ps` if you'd 
like to connect to those.
