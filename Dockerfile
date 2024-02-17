ARG DBT_VERSION=1.5.2
FROM ghcr.io/dbt-labs/dbt-core:${DBT_VERSION}

RUN set -ex \
    && python -m pip install --upgrade pip setuptools \
    && python -m pip install --upgrade dbt-clickhouse==1.5.2

WORKDIR /usr/app/
ENV DBT_PROFILES_DIR=.

ENTRYPOINT ["tail", "-f", "/dev/null"]
