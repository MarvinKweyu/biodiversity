# biocounter

A computer-vision application for counting flowers

- [biocounter](#biocounter)
  - [Settings](#settings)
  - [Basic Commands](#basic-commands)
    - [Running a local instance](#running-a-local-instance)
    - [Setting Up Users](#setting-up-users)
      - [Running tests with pytest](#running-tests-with-pytest)
    - [Test coverage](#test-coverage)
  - [Deployment](#deployment)

## Settings

## Basic Commands

### Running a local instance

```bash
docker compose -f docker-compose.local.yml up --build
```

Access the administrative dashboard on `http://127.0.0.1:8000/admin`.

> [!NOTE]  
> (WIP) For this setup , administrative credentials have been provided as below:

Email:

Password:


### Setting Up Users

- To create a **superuser account**, use this command:

      $ docker compose -f docker-compose.local.yml run --rm django python manage.py createsuperuser


#### Running tests with pytest

    $ pytest


### Test coverage

To run the tests, check your test coverage, and generate an HTML coverage report:

    $ coverage run -m pytest
    $ coverage html
    $ open htmlcov/index.html

## Deployment


```bash
docker compose -f docker-compose.production.yml up --build
```
