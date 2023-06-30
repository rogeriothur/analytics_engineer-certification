WITH src_country_region AS (
    SELECT * FROM {{ source('sap', 'countryregion') }}
),

country_regions AS (
    SELECT
        -- primary key
        countryregioncode AS country_region_code

        -- strings
        , name AS country_region_name
    
        -- date & timestamp
        , TO_TIMESTAMP(MODIFIEDDATE) AS modified_date

    FROM
        src_country_region
)

SELECT * FROM country_regions