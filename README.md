# Demo project (tutorial)

Intro  (description):
- dbt project
- Clickhouse + Metabase

Requirements:
- IDE
- Docker

TODO:
- [ ] README.md with steps & GIFs
- [ ] Table of contents
- [x] TODO: release versions, install from tag not branch
- [x] Pin repository

## Configure environment

- [x] Init dbt project
- [x] Choose database: Clickhouse
- [x] Configure Docker containers (dbt, clickhouse, postgres)

```bash
# launch containers: dbt, clickhouse, postgres
docker-compose build --no-cache
docker-compose up -d

# alias running dbt commands in a docker container
alias dev="docker-compose exec dev"

# test connections
dev dbt --version
dev dbt debug
```

## Install mybi_dbt_core package

- [x] Install module via `packages.yml` - `dbt deps`
- [x] `dbt_project.yml`
- [x] Enable only relevant sources (and disable the rest) `dbt ls --resource-type model -s tag:ga`
- [x] Assign variables
- [x] Turn on custom schema management

```bash
# install dependencies (modules)
dev dbt clean
dev dbt deps
```

## Build staging layer

- [x] Source dataset (myBI) - `dbt run-operation init_source_data`
- [x] Build staging layer - `dev dbt run --full-refresh -s tag:staging`

```bash
# build and test on dummy data
dev dbt ls --resource-type model -s tag:staging # tag:ga
dev dbt run-operation init_source_data
dev dbt run --full-refresh -s tag:staging # stg_ga_devices 
```

## Build data models

- [x] Transformations (business value)
DAG screenshot
- [x] Tests & Docs

```bash
dev dbt build --full-refresh -s tag:staging+ --exclude tag:staging
```

## Visualize on a dashboard

- [x] Visualize with BI tool

Metabase backup H2 database:

```bash
docker-compose cp metabase:/metabase.db ./metabase/
docker-compose exec metabase bash
```

Access dashboard at http://localhost:3000/dashboard/1-mybi-tutorial
mybi@dbt.tutorial
tutorial101

## View project docs

- [ч] dbt Docs step

```bash
dev dbt docs generate
dev dbt docs serve
```

https://kzzzr.github.io/mybi-dbt-showcase/#!/overview

## Introduce Continuous Integration

- [x] Protect master branch
- [x] Introduce CI

Let's say you want to introduce some changes to code.
How to ensure data quality?

## Contributing

Development workflow looks like this: 

```bash
# launch containers: dbt, clickhouse, postgres
docker-compose build --no-cache
docker-compose up -d

# alias running dbt commands in a docker container
alias dev="docker-compose exec dev"

# test connections
dev dbt --version
dev dbt debug

# introduce any code changes

# install dependencies (modules)
dev dbt clean
dev dbt deps

# build and test on dummy data
dev dbt run-operation init_source_data
dev dbt run --full-refresh -s tag:staging
dev dbt build --full-refresh -s tag:staging+ --exclude tag:staging

# exit container and clean up
docker-compose down
```
