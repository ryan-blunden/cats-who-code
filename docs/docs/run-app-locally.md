# Running the App Locally

## Bringing up the stack

From the project root directory and run:
 
    make app-dev-start ARGS=--build

This will build the local Docker images and run the containers using Docker Compose.

Once the stack has finished coming up, ensure the app is receiving requests by going to [http://localhost:8080](http://localhost:8080).

The app is not yet in a healthy state as the MySQL database has not been created and the S3 bucket running on the Minio server has also not been created. 

## Initializing the MySQL database

From the project root, change into the `app` (The Django application directory).

Then setup the MySQL database that Django uses by running the following commands:

    make db-create-dev   
    
## Creating the bucket

Still in `app`, run:

    make bucket-create-dev

## Health Check

The health check should return all systems normal. [http://localhost:8080/health-check/](http://localhost:8080/health-check/).

## The final test - Login to the admin

First, create a `superuser` account by running the following command:

    make superuser

Visit [http://localhost:8080/manage/](http://localhost:8080/manage/) using the details you entered.

## Creating your first Cat upload

Head to [http://localhost:8080/manage/cats/cat/](http://localhost:8080/manage/cats/cat/) and upload a Cat coding photo.

You can (presuming you set the photo to approved) see the photo in the cats feed at [http://localhost:8080/api/v1/cats/](http://localhost:8080/api/v1/cats/).

## Index of Services 

Here is a list of services that are available in standalone (dev) mnode:

- ***NGINX Front-End (serves the Django app)**: [http://localhost:8080/](http://localhost:8080/).
- **Python (Django) App server**: [http://localhost:8000/](http://localhost:8080/).
- **MySQL**: 127.0.0.1 on port 3306.
- **Redis**: 127.0.0.1 on port 6379.
- **Minio (S3) Browser**: [http://localhost:9000/minio/](http://localhost:9000/minio/).
- **Redis GUI**: [http://localhost:8081/](http://localhost:8081/).
- **Mail Server**: [http://localhost:8082/](http://localhost:8082/).
- **Docs**: [http://localhost:3000/](http://localhost:3000/).
- **Portainer Docker GUI**: [http://localhost:9001/](http://localhost:9001/).

There are other services (e.g. mock mail server and redis) that have a dynamic host port bound. Use `docker ps` if you'd 
like to connect to those.

## Bringing down the stack

Sending a SIGINT (CTRL+C) should shut things down cleanly but in case it does not, just run:

    make app-dev-stop