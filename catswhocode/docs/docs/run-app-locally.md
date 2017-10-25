# Running the App Locally

Change into the `catswhocode` directory and run `make server`.

## Services 

- Python App server (admin and API): [http://localhost:8080/](http://localhost:8080/).
- Docs: [http://localhost:8000/](http://localhost:8000/).
- MySQL: 127.0.0.1 on port 3306.
- Portainer (Container management GUI): [http://localhost:9000/](http://localhost:9000/).

There are other services (e.g. mock mail server and redis) that have a dynamic host port bound. Use `docker ps` if you'd 
like to connect to those.

## Running the app locally for development

Change into the `catswhocode` directory and run `make devserver`. This uses Django's built-in development server for live reloads.
