{% macro init_source_data() -%}

    {% set sql %}

        CREATE DATABASE IF NOT EXISTS mybi
        ENGINE = PostgreSQL(
              '{{ var("mybi_host") }}:{{ var("mybi_port") }}'
            , '{{ var("mybi_database") }}'
            , '{{ var("mybi_user") }}'
            , '{{ var("mybi_password") }}'
            , '{{ var("mybi_schema") }}')
        ;

    {% endset %}
    
    {% set result = run_query(sql) %}

    {{ print('Initialized source database') }}

{%- endmacro %}