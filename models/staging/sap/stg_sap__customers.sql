WITH src_customer AS (
    SELECT * FROM {{ source('sap', 'customer') }}
),

customers AS (
    SELECT
        -- primary key
        customerid AS customer_id

        -- foreign keys
        , personid AS person_id
        , storeid AS store_id
        , territoryid AS territory_id

        -- date & timestamp
        , TO_TIMESTAMP(MODIFIEDDATE) AS modified_date

        -- unique key
        , rowguid AS row_guid
    FROM
        src_customer
)
SELECT * FROM customers