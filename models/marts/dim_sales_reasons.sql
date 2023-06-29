{{ config(materialized="table") }}

WITH sales_reasons AS (
    SELECT * FROM {{ ref('stg_sap__sales_reasons') }}
),

dim_sales_reasons AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['sales_reason_id']) }} AS sales_reason_sk
        , sales_reason_id
        , sales_reason_name
        , reason_type
    FROM
        sales_reasons
)

SELECT * FROM dim_sales_reasons