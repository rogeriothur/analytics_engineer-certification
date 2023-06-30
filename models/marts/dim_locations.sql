{{ config(materialized="table") }}

WITH addresses AS (
    SELECT * FROM {{ ref('stg_sap__addresses') }}
),

state_provinces AS (
    SELECT * FROM {{ ref('stg_sap__state_provinces') }}
),

country_regions AS (
    SELECT * FROM {{ ref('stg_sap__country_regions') }}
),

dim_locations AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['address_id']) }} AS location_sk
        , address_id
        , ad.state_province_id
        , sp.territory_id
        , ad.city
        , sp.state_province_name
        , sp.state_province_code
        , cr.country_region_name
        , sp.country_region_code

    FROM
        addresses AS ad
    LEFT JOIN
        state_provinces AS sp ON ad.state_province_id = sp.state_province_id
    LEFT JOIN
        country_regions AS cr ON sp.country_region_code = cr.country_region_code
)

SELECT * FROM dim_locations