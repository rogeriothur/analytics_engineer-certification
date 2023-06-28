WITH src_customer AS (
    SELECT * FROM {{ source('sap', 'customer') }}
),

customers AS (
    SELECT
        -- primary key
        customerid

        -- foreign keys
        , personid
        , storeid
        , territoryid

        -- date & timestamp
        , TO_TIMESTAMP(MODIFIEDDATE) AS modifieddate

        -- unique key
        , rowguid
    FROM
        src_customer
)
SELECT * FROM customers