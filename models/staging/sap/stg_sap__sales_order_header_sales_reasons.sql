WITH src_sales_order_header_sales_reason AS (
    SELECT * FROM {{ source('sap', 'salesorderheadersalesreason') }}
),

sales_order_header_sales_reasons AS (
    SELECT
        -- primary key
        salesorderid AS sales_order_id
       , salesreasonid AS sales_reason_id

        -- date & timestamp
        , TO_TIMESTAMP(MODIFIEDDATE) AS modified_date
    FROM
        src_sales_order_header_sales_reason
)
SELECT * FROM sales_order_header_sales_reasons