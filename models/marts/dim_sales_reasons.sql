{{ config(materialized="table") }}

WITH sales_reasons AS (
    SELECT * FROM {{ ref('stg_sap__sales_reasons') }}
),

sales_order_header_sales_reasons AS (
    SELECT * FROM {{ ref('stg_sap__sales_order_header_sales_reasons') }}
),

cleasing AS (
    SELECT
        header.sales_order_id
        , listagg(reason.sales_reason_name , ', ') AS sales_reason_name
    FROM
        sales_reasons AS reason
    LEFT JOIN
        sales_order_header_sales_reasons AS header
        ON reason.sales_reason_id = header.sales_reason_id
    GROUP BY
        header.sales_order_id  
),

dim_sales_reasons AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['sales_order_id']) }} AS sales_order_sk
        , *
    FROM
        cleasing
)

SELECT * FROM dim_sales_reasons