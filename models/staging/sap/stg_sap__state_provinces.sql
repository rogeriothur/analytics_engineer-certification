WITH src_state_province AS (
    SELECT * FROM {{ source('sap', 'stateprovince') }}
),

state_provinces AS (
    SELECT
        -- primary key
        stateprovinceid AS state_province_id

        -- foreign keys
        , territoryid AS territory_id
        , countryregioncode AS country_region_code

        -- strings
        , stateprovincecode AS state_province_code
        , name AS state_province_name
        
        -- boolean
        , isonlystateprovinceflag AS is_only_state_province_flag

        -- date & timestamp
        , TO_TIMESTAMP(MODIFIEDDATE) AS modified_date

        -- unique key
        , rowguid AS row_guid
    FROM
        src_state_province
)

SELECT * FROM state_provinces