WITH src_salesreason AS (
    SELECT * FROM {{ source('sap', 'salesreason') }}
),

salesreasons AS (
    SELECT
        -- primary key
       salesreasonid

        -- strings
        , name
        , reasontype

        -- date & timestamp
        , TO_TIMESTAMP(MODIFIEDDATE) AS modified_date
    FROM
        src_salesreason
)
SELECT * FROM salesreasons