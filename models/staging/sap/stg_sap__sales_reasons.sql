WITH src_sales_reason AS (
    SELECT * FROM {{ source('sap', 'salesreason') }}
),

sales_reasons AS (
    SELECT
        -- primary key
       salesreasonid AS sales_reason_id

        -- strings
        , name AS sales_reason_name
        , reasontype AS reason_type

        -- date & timestamp
        , TO_TIMESTAMP(MODIFIEDDATE) AS modified_date
    FROM
        src_sales_reason
)
SELECT * FROM sales_reasons