SELECT
      
      facts.dt AS dt
    , {{ dbt_utils.surrogate_key([
          'facts.dt'
        , 'facts.account_id'
        , 'facts.campaigns_id'
        , 'facts.sites_id'
        , 'facts.traffic_id'
        ]) }} AS cost_id

    -- ACCOUNTS
    , facts.account_id AS account_id
    , accounts.caption AS account_caption
    , accounts.service AS account_service
    , accounts.enabled AS account_enabled
    , accounts.status AS account_status
    , accounts.interval_start AS account_interval_start
    , accounts.interval_end AS account_interval_end

    -- CAMPAIGNS
    --, facts.campaigns_id
    , campaigns.campaign_id AS campaign_id
    , campaigns.name AS campaign_name
    , campaigns.system_status AS campaign_system_status
    , campaigns.status AS campaign_status
    , campaigns.autobidding AS campaign_autobidding
    , campaigns.mixing AS campaign_mixing
    , campaigns.age_restrictions AS campaign_age_restrictions
    , campaigns.group_members AS campaign_group_members
    , campaigns.extended_age AS campaign_extended_age
    , campaigns.enable_utm AS campaign_enable_utm
    , campaigns.utm     AS campaign_utm

    -- SITES
    --, facts.sites_id
    , sites.domain AS sites_domain
    , sites.description AS sites_description

    -- TRAFFIC
    --, facts.traffic_id
    , traffic.grouping AS traffic_grouping
    , traffic.source AS traffic_source
    , traffic.medium AS traffic_medium
    , traffic.campaign AS traffic_campaign
    , traffic.content AS traffic_content
    , traffic.keyword AS traffic_keyword
    , traffic.landing_page AS traffic_landing_page

    -- MEASURES
    , sum(facts.impressions) AS impressions
    , sum(facts.clicks) AS clicks
    , sum(facts.cost) AS cost

FROM {{ ref('stg_mt_banners_facts') }} AS facts
    LEFT JOIN {{ ref('stg_general_accounts') }} AS accounts ON accounts.account_id = facts.account_id
    LEFT JOIN {{ ref('stg_mt_campaigns') }} AS campaigns ON campaigns.id = facts.campaigns_id
    LEFT JOIN {{ ref('stg_general_sites') }} AS sites ON sites.id = facts.sites_id
    LEFT JOIN {{ ref('stg_general_traffic') }} AS traffic ON traffic.id = facts.traffic_id

GROUP BY

      facts.dt
    , cost_id

    -- ACCOUNTS
    , facts.account_id AS account_id
    , accounts.caption AS account_caption
    , accounts.service AS account_service
    , accounts.enabled AS account_enabled
    , accounts.status AS account_status
    , accounts.interval_start AS account_interval_start
    , accounts.interval_end AS account_interval_end

    -- CAMPAIGNS
    --, facts.campaigns_id
    , campaigns.campaign_id AS campaign_id
    , campaigns.name AS campaign_name
    , campaigns.system_status AS campaign_system_status
    , campaigns.status AS campaign_status
    , campaigns.autobidding AS campaign_autobidding
    , campaigns.mixing AS campaign_mixing
    , campaigns.age_restrictions AS campaign_age_restrictions
    , campaigns.group_members AS campaign_group_members
    , campaigns.extended_age AS campaign_extended_age
    , campaigns.enable_utm AS campaign_enable_utm
    , campaigns.utm     AS campaign_utm

    -- SITES
    --, facts.sites_id
    , sites.domain AS sites_domain
    , sites.description AS sites_description

    -- TRAFFIC
    --, facts.traffic_id
    , traffic.grouping AS traffic_grouping
    , traffic.source AS traffic_source
    , traffic.medium AS traffic_medium
    , traffic.campaign AS traffic_campaign
    , traffic.content AS traffic_content
    , traffic.keyword AS traffic_keyword
    , traffic.landing_page AS traffic_landing_page