# biocounter

A computer-vision application for counting flowers

- [biocounter](#biocounter)
  - [Running a local instance](#running-a-local-instance)
    - [Setting Up Users](#setting-up-users)
      - [Running tests with pytest](#running-tests-with-pytest)
    - [Test coverage](#test-coverage)
  - [Deployment](#deployment)




## Running a local instance

```bash
docker compose -f docker-compose.local.yml up --build
```

Access the administrative dashboard on `http://127.0.0.1:8000/admin`.


### Setting Up Users

- To create a **superuser account**, use this command:

      $ docker compose -f docker-compose.local.yml run --rm django python manage.py createsuperuser



Alternatively, you can create one from the below:

```bash
docker compose -f docker-compose.local.yml run --rm django python manage.py createadmin
```
This will create an administrator with the credentials:

```
ADMIN_USERNAME=bioadmin

ADMIN_EMAIL=admin@bioadmin.com

ADMIN_PASSWORD=adminpassword
```

API documentation for the project can be accessed (once logged as an admin) on `http://127.0.0.1:8000/api/docs`.


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
