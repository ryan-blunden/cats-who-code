# Cats Who Code

Instragram like feed but of cats or kittens who either are coding, or think they're coding. Used for learning Docker and AWS.

## System Requirements

- Docker for Mac/Widows (if you're on Linux, you'll know what to do).
- Make.

## To get the app running in a development environment

**1.** Go into the `app` directory and rename `app.env.dev-example` to `app.env`.

**NOTE**: If you are running this on a Virtual Machine and not locally using Docker for Desktop, you will need to uncomment the `AWS_S3_CUSTOM_DOMAIN` line, entering the host name of your VM.

**2.** Then build the containers and run the application in development (files mounted in the container) mode.

    make app-dev-start
    
**3.** Then once the containers are running, go to the docs site at http://localhost:3000/run-app-locally/ to learn how to complete the application setup process.

## To get the app running in a production environment

There are a lot of ways to run this in production, but for a simple case, where you want to build and run the containers using Docker Compose.

**1.** Go into the `app` directory and rename `app.env.production-example` to `app.env`. Then tweak the variables based on your RDS, ElastiCache and S3 bucket settings.

**2.** In the project root, build the front-end and API containers locally by running:

    make build

IDeally, these would be pulled from a remote Docker Registry.

**3.** Bring up the front-end and API containers by running:

    make app-start
