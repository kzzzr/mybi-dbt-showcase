SELECT

      facts.dt AS dt
    , {{ dbt_utils.surrogate_key([
          'facts.dt'
        , 'facts.session_id'
        , 'facts.user_type'
        ]) }} AS event_id
    , facts.session_id AS session_id
    , facts.user_type AS user_type

    -- ACCOUNTS
    , facts.account_id AS account_id
    , accounts.caption AS account_caption
    , accounts.service AS account_service
    , accounts.enabled AS account_enabled
    , accounts.status AS account_status
    , accounts.interval_start AS account_interval_start
    , accounts.interval_end AS account_interval_end

    -- SITES
    --, facts.sites_id AS sites_id
    , sites.domain AS sites_domain
    , sites.description AS sites_description

    -- CLIENTS
    --, facts.clientids_id AS clientids_id
    , clients.clientid AS client_id
    , clients.userid AS client_userid
    , clients.phone AS client_phone
    , clients.email AS client_email

    -- DEVICES
    --, facts.devices_id AS devices_id
    , devices.category AS device_category
    , devices.browser AS device_browser
    , devices.browser_version AS device_browser_version
    , devices.os AS device_os
    , devices.os_version AS device_os_version

    -- TRAFFIC
    --, facts.traffic_id AS traffic_id
    , traffic.grouping AS traffic_grouping
    , traffic.source AS traffic_source
    , traffic.medium AS traffic_medium
    , traffic.campaign AS traffic_campaign
    , traffic.content AS traffic_content
    , traffic.keyword AS traffic_keyword
    , traffic.landing_page AS traffic_landing_page

    -- LOCATIONS
    --, facts.locations_id AS locations_id
    , locations.country_iso AS location_country_iso
    , locations.country AS location_country
    , locations.region_iso AS location_region_iso
    , locations.region AS location_region
    , locations.city AS location_city
    , locations.latitude AS location_latitude
    , locations.longitude AS location_longitude

    -- MEASURES
    , facts.sessions AS sessions
    , facts.bounces AS bounces
    , facts.pageviews AS pageviews
    , facts.duration AS duration

FROM {{ ref('stg_ga_sessions_facts') }} AS facts
    LEFT JOIN {{ ref('stg_general_accounts') }} AS accounts ON accounts.account_id = facts.account_id
    LEFT JOIN {{ ref('stg_general_sites') }} AS sites ON sites.id = facts.sites_id
    LEFT JOIN {{ ref('stg_general_clientids') }} AS clients ON facts.clientids_id = clients.id
    LEFT JOIN {{ ref('stg_ga_devices') }} AS devices ON devices.id = facts.devices_id
    LEFT JOIN {{ ref('stg_general_traffic') }} AS traffic ON traffic.id = facts.traffic_id
    LEFT JOIN {{ ref('stg_general_locations') }} AS locations ON locations.id = facts.locations_id
