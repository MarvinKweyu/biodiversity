# BiocounterClient
> A client facing web application for the biocounter API

[![Node](https://img.shields.io/badge/node-20.12-green)](https://github.com/angular/angular-cli)
[![Angular](https://img.shields.io/badge/angular-18.1.0-red)](https://github.com/angular/angular-cli)


- [BiocounterClient](#biocounterclient)
  - [Development server](#development-server)
  - [Docker(It just works)](#dockerit-just-works)
  - [Build](#build)
  - [Running unit tests](#running-unit-tests)

## Development server

```bash
npm install
ng serve
```

Navigate to [http://localhost:4200/](http://localhost:4200/).

## Docker(It just works)

This will take a minute for the first run.
```bash

docker-compose -f local.yml up --build

```

Navigate to `http://localhost:4200/`.

To terminate the process:

```bash
docker-compose -f local.yml down
```

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).
