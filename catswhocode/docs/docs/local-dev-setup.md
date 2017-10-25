# Local Dev Setup
 
## System Requirements

Install the following.

- Docker for Mac/Widows.
- Make.
- Python (optional).
- MySQL GUI (optional).

!!! note "Note!"

    Python is not technically required as the application server runs in a Docker container. You only need it if you
    plan on doing Python development to the Django application.
    
## Python local development environment 

The `catswhocode` directory contains the Python (Django) application code. Change into that directory, then follow the 
below instructions.

Python is not technically required as the application server runs in a Docker container. If you are doing Python 
development and want to have code completion, then you'll need to setup a local Python environment that your editor
has visibility into.

We use [pipenv](https://docs.pipenv.org/) as it's the best way of handling Python package dependencies.

For installing Python, Chocolatey is recommended for Windows users and Homebrew for Mac.

!!! note "Note!"

    You may have to run `pip` instead of `pip3` below.

1. Install a Python 3 distribution.
1. Install the MySQL client (depends on package manager, e.g. `brew install mysql`) as it's required for the Python MySQL driver.
1. Run `pip3 install --upgrade pip setuptools`.
1. Run `pip3 install pipenv`.
1. Run `pipenv install`.
1. In your editor of choice,  configure it to know about virtual environment directory pipenv just created. Where this
is depends on your OS.

## Create MySQL database

1. Run `docker-compose up`.
1. Connect your MySQL client of choice to 127.0.0.1:3306.
1. Create the database `catswhocode` with the Character Set and Collation et to UTF-8.
