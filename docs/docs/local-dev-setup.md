# For Django Developers working on Cats Who Code

!!! note "Note!"

    This is a guide for developers that want to work on the Cats Who Code application. These instructions are not required to simply run the app.

Install the following:

- Docker for Mac/Widows.
- Make.
- Python (optional).
- MySQL GUI (optional).

If you don't plan on doing any Python/Django development, you're done!

## Python virtual environment for IDE code completion 

!!! note "Note!"

    Python is not technically required as the application server runs in a Docker container. You only need it if you
    plan on further developing the Cats Who Code application and want to create a Virtual Environment that your Python 
    IDE can use to enable code completion.

The `catswhocode` directory contains the Python (Django) application code. Change into that directory, then follow the 
below instructions.

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
