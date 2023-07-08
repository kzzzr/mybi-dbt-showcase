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
    , campaign_id
    , campaign_name
    , campaign_state
    
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
    , impressions
    , clicks
    , cost
    , sessions
    , bounces
    , pageviews
    , duration
    , goal_completions
    , goal_value   

FROM {{ ref('f_tracker') }}
where user_type = 'New Visitor' and YEAR(dt) = YEAR(now())