WITH src_address AS (
    SELECT * FROM {{ source('sap', 'address') }}
),

addresses AS (
    SELECT
        -- primary key
        addressid AS address_id

        -- foreign keys
        , stateprovinceid AS state_province_id

        -- strings
        , addressline1 AS address_line_1
        , addressline2 AS address_line_2
        , city
        , postalcode AS postal_code
        , spatiallocation AS spatial_location

        -- date & timestamp
        , TO_TIMESTAMP(MODIFIEDDATE) AS modified_date

        -- unique key
        , rowguid AS row_guid
    FROM
        src_address
)

SELECT * FROM addresses