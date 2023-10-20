{{
    config (
      materialized='ephemeral'
    )
}}

select sessions,bounces  from f_tracker