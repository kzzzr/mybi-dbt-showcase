{{
    config (
      materialized='table',
      order_by=["dt", "account_service"]
    )
}}

-- SESSIONS
SELECT

      dt
    , event_id
    , user_type

    -- ACCOUNTS
    , account_id
    , account_caption
    , account_service
    , account_enabled
    , account_status
    , account_interval_start
    , account_interval_end

    -- SITES
    , sites_domain
    , sites_description

    -- CLIENTS
    , client_id
    , client_phone
    , client_email

    -- DEVICES
    , UPPER(device_category) AS device_category
    , device_browser
    , device_browser_version
    , device_os
    , device_os_version

    -- TRAFFIC
    , traffic_grouping
    , traffic_source
    , traffic_medium
    , traffic_campaign
    , traffic_content
    , traffic_keyword
    , traffic_landing_page

    -- LOCATIONS
    , location_country_iso
    , location_country
    , location_region_iso
    , location_region
    , location_city

    -- GOALS
    , NULL AS goal_id
    , NULL AS goal_name

    -- MEASURES
    , sessions
    , bounces
    , pageviews
    , duration
    , NULL AS goal_completions
    , NULL AS goal_value

FROM {{ ref('int_ga_sessions_facts') }}

UNION ALL

-- GOAL COMPLETIONS
SELECT

      dt
    , event_id
    , NULL AS user_type

    -- ACCOUNTS
    , account_id
    , account_caption
    , account_service
    , account_enabled
    , account_status
    , account_interval_start
    , account_interval_end

    -- SITES
    , sites_domain
    , sites_description

    -- CLIENTS
    , client_id
    , client_phone
    , client_email

    -- DEVICES
    , UPPER(device_category) AS device_category
    , device_browser
    , device_browser_version
    , device_os
    , device_os_version

    -- TRAFFIC
    , traffic_grouping
    , traffic_source
    , traffic_medium
    , traffic_campaign
    , traffic_content
    , traffic_keyword
    , traffic_landing_page

    -- LOCATIONS
    , location_country_iso
    , location_country
    , location_region_iso
    , location_region
    , location_city

    -- GOALS
    , goal_id
    , goal_name

    -- MEASURES
    , NULL AS sessions
    , NULL AS bounces
    , NULL AS pageviews
    , NULL AS duration
    , goal_completions
    , goal_value

FROM {{ ref('int_ga_goals_facts') }}
