## (WIP) Demo project (tutorial)

- [x] Init dbt project
- [x] Choose database: Clickhouse
- [ ] Configure Docker containers (dbt, clickhouse, postgres)
- [x] Source dataset (myBI)
- [ ] Install module via `packages.yml`
- [ ] Assign variables
- [ ] Transformations (business value)
- [ ] Tests & Docs
- [ ] Visualize with BI tool (mProve, Superset, Redash)
- [ ] dbt Docs as Github Pages
- [ ] Protect master branch and introduce CI

- [ ] TODO: release verisions, install from tag not branch

## Contributing

Development workflow looks like this: 

```bash
# launch containers: dbt, clickhouse, postgres
docker-compose build # --no-cache
docker-compose up -d

# enter container with dbt installed
docker-compose exec dbt bash

# test connections
dbt --version
dbt debug --target clickhouse
dbt debug --target postgres

# introduce any code changes

# install dependencies (modules)
dbt clean
dbt deps

# build and test on dummy data
dbt seed --full-refresh
dbt build --full-refresh

# exit container and clean up
docker-compose down
```
