{{ config(materialized="table") }}

WITH products AS (
    SELECT * FROM {{ ref('stg_sap__products') }}
),

dim_products AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_sk
        , *
    FROM
        products
)

SELECT * FROM dim_products