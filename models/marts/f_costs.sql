{{
    config (
      materialized='table',
      order_by=["dt", "account_service"]
    )
}}

-- Yandex.Direct CONTEXT
SELECT

      dt
    , cost_id
    , device

    , account_id
    , account_caption
    , account_service
    , account_enabled
    , account_status
    , account_interval_start
    , account_interval_end
    
    , campaign_id
    , campaign_name
    , campaign_state
    
    , sites_domain
    , sites_description
    
    , traffic_grouping
    , traffic_source
    , traffic_medium
    , traffic_campaign
    , traffic_content
    , traffic_keyword
    , traffic_landing_page
    
    , impressions
    , clicks
    , cost
    --, bounces
    
FROM {{ ref('int_yd_campaigns_facts_context') }}

UNION ALL

-- Yandex.Direct SEARCH
SELECT

      dt
    , cost_id
    , device

    , account_id
    , account_caption
    , account_service
    , account_enabled
    , account_status
    , account_interval_start
    , account_interval_end

    , campaign_id
    , campaign_name
    , campaign_state

    , sites_domain
    , sites_description

    , traffic_grouping
    , traffic_source
    , traffic_medium
    , traffic_campaign
    , traffic_content
    , traffic_keyword
    , traffic_landing_page

    , impressions
    , clicks
    , cost
    , bounces

FROM {{ ref('int_yd_campaigns_facts_search') }}

UNION ALL

-- myTarget
SELECT

      dt
    , cost_id
    , 'unknown' AS device

    , account_id
    , account_caption
    , account_service
    , account_enabled
    , account_status
    , account_interval_start
    , account_interval_end

    , campaign_id::String
    , campaign_name
    , campaign_status

    , sites_domain
    , sites_description

    , traffic_grouping
    , traffic_source
    , traffic_medium
    , traffic_campaign
    , traffic_content
    , traffic_keyword
    , traffic_landing_page

    , impressions
    , clicks
    , cost

FROM {{ ref('int_mytarget_campaigns_facts') }}
