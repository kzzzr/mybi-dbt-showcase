{{
    config (
      materialized='table',
      order_by=["dt", "account_service"]
    )
}}

-- EVENTS
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

    -- TRAFFIC
    , traffic_grouping
    , traffic_source
    , traffic_medium
    , traffic_campaign
    , traffic_content
    , traffic_keyword
    , traffic_landing_page

    -- DEVICES
    , device_category
    , device_browser
    , device_browser_version
    , device_os
    , device_os_version
    
    -- CAMPAIGNS
    , NULL AS campaign_id
    , NULL AS campaign_name
    , NULL AS campaign_state
    
    -- CLIENTS
    , client_id
    , client_phone
    , client_email

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
    , NULL AS impressions
    , NULL AS clicks
    , NULL AS cost
    , sessions
    , bounces
    , pageviews
    , duration
    , goal_completions
    , goal_value   

FROM {{ ref('f_ga_events') }}

UNION ALL

SELECT

      dt
    , cost_id
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

    -- TRAFFIC
    , traffic_grouping
    , traffic_source
    , traffic_medium
    , traffic_campaign
    , traffic_content
    , traffic_keyword
    , traffic_landing_page

    -- DEVICES
    , device AS device_category
    , NULL AS device_browser
    , NULL AS device_browser_version
    , NULL AS device_os
    , NULL AS device_os_version
    
    -- CAMPAIGNS
    , campaign_id
    , campaign_name
    , campaign_state
    
    -- CLIENTS
    , NULL AS client_id
    , NULL AS client_phone
    , NULL AS client_email

    -- LOCATIONS
    , NULL AS location_country_iso
    , NULL AS location_country
    , NULL AS location_region_iso
    , NULL AS location_region
    , NULL AS location_city

    -- GOALS
    , NULL AS goal_id
    , NULL AS goal_name

    -- MEASURES
    , impressions
    , clicks
    , cost
    , NULL AS sessions
    , NULL AS bounces
    , NULL AS pageviews
    , NULL AS duration
    , NULL AS goal_completions
    , NULL AS goal_value    

FROM {{ ref('f_costs') }}