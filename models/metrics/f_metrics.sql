{{
    config (
      materialized='table'
    )
}}


select 
    * 
from {{ metrics.calculate(
        metric_list=[metric('costs')]
        , grain='month'
        , dimensions=['traffic_source']
        , date_alias='reporting_date'
        )
    }}
