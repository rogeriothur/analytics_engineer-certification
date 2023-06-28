WITH src_salesreason AS (
    SELECT * FROM {{ source('sap', 'salesreason') }}
),

salesreason AS (
    SELECT
        -- primary key
       salesreasonid

        -- strings
        , name
        , reasontype

        -- date & timestamp
        , DATE(modifieddate, 'AUTO') AS modifieddate
    FROM
        src_salesreason
)
SELECT * FROM salesreason