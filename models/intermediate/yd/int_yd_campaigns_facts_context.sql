SELECT

      facts.dt AS dt
    , {{ dbt_utils.surrogate_key([
          'facts.dt'
        , 'facts.account_id'
        , 'account_service'        
        , 'facts.campaigns_id'
        , 'facts.sites_id'
        , 'facts.traffic_id'
        , 'facts.device'
        ]) }} AS cost_id

    -- ACCOUNTS
    , facts.account_id AS account_id
    , accounts.caption AS account_caption
    , 'Яндекс.Директ – Контекст' AS account_service
    , accounts.enabled AS account_enabled
    , accounts.status AS account_status
    , accounts.interval_start AS account_interval_start
    , accounts.interval_end AS account_interval_end
    
    -- CAMPAIGNS
    --, facts.campaigns_id
    , campaigns.campaign_id AS campaign_id
    , campaigns.name AS campaign_name
    , campaigns.campaign_type AS campaign_type
    , campaigns.status AS campaign_status
    , campaigns.state AS campaign_state
    , campaigns.status_payment AS campaign_status_payment
    , campaigns.status_clarification AS campaign_status_clarification
    , campaigns.currency AS campaign_currency
    , campaigns.daily_budget_amount AS campaign_daily_budget_amount
    , campaigns.daily_budget_mode AS campaign_daily_budget_mode

    -- SITES
    --, facts.sites_id AS sites_id
    , sites.domain AS sites_domain
    , sites.description AS sites_description

    -- TRAFFIC
    --, facts.traffic_id AS traffic_id
    , traffic.grouping AS traffic_grouping
    , traffic.source AS traffic_source
    , traffic.medium AS traffic_medium
    , traffic.campaign AS traffic_campaign
    , traffic.content AS traffic_content
    , traffic.keyword AS traffic_keyword
    , traffic.landing_page AS traffic_landing_page

    , facts.device AS device

    -- measures
    , sum(facts.impressions_context) AS impressions
    , sum(facts.clicks_context) AS clicks
    , sum(facts.cost_context) AS cost
    , sum(facts.bounces) AS bounces

FROM {{ ref('stg_yd_ads_facts') }} AS facts
    LEFT JOIN {{ ref('stg_general_accounts') }} AS accounts ON accounts.account_id = facts.account_id
    LEFT JOIN {{ ref('stg_yd_campaigns') }} AS campaigns ON campaigns.id = facts.campaigns_id
    LEFT JOIN {{ ref('stg_general_sites') }} AS sites ON sites.id = facts.sites_id
    LEFT JOIN {{ ref('stg_general_traffic') }} AS traffic ON traffic.id = facts.traffic_id

GROUP BY 

      facts.dt
    , cost_id

    -- ACCOUNT
    , facts.account_id
    , accounts.caption
    , accounts.service
    , accounts.enabled
    , accounts.status
    , accounts.interval_start
    , accounts.interval_end    
    
    -- CAMPAIGNS
    --, facts.campaigns_id
    , campaigns.campaign_id
    , campaigns.name
    , campaigns.campaign_type
    , campaigns.status
    , campaigns.state
    , campaigns.status_payment
    , campaigns.status_clarification
    , campaigns.currency
    , campaigns.daily_budget_amount
    , campaigns.daily_budget_mode

    -- SITES
    --, facts.sites_id
    , sites.`domain`
    , sites.description

    -- TRAFFIC
    --, facts.traffic_id
    , traffic.`grouping`
    , traffic.`source`
    , traffic.medium
    , traffic.campaign
    , traffic.content
    , traffic.keyword
    , traffic.landing_page

    , facts.device