{{ config(materialized="table") }}

WITH sales_reasons AS (
    SELECT * FROM {{ ref('stg_sap__sales_reasons') }}
),

sales_order_header_sales_reasons AS (
    SELECT * FROM {{ ref('stg_sap__sales_order_header_sales_reasons') }}
),
dim_sales_reasons AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['reason.sales_reason_id']) }} AS sales_reason_sk
        , reason.sales_reason_id
        , header.sales_order_id
        , reason.sales_reason_name
        , reason.reason_type
    FROM
        sales_reasons AS reason
    LEFT JOIN
        sales_order_header_sales_reasons AS header ON reason.sales_reason_id = header.sales_reason_id
)

SELECT * FROM dim_sales_reasons