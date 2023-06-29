{{ config(materialized='table') }}

WITH products AS (
    SELECT * FROM {{ ref('stg_sap__products') }}
),

subcategories AS (
    SELECT * FROM {{ ref('stg_sap__product_subcategories') }}
),

categories AS (
    SELECT * FROM {{ ref('stg_sap__product_categories') }}
),

join_tables AS (
    SELECT
        -- ids
        -- nao estou trazendo o product_model_id
        prod.product_id
        , sub.product_subcategory_id AS product_subcategory_fk
        , cat.product_category_id AS product_category_fk
        
        -- strings
        , prod.product_number
        , prod.class
        , prod.color
        , prod.size
        , prod.size_unit_measure_code
        , prod.weight_unit_measure_code
        , prod.style
        , prod.product_line
        , sub.product_subcategory_name
        , cat.product_category_name
        
        -- numeric
        , prod.standard_cost
        , prod.list_price
        , prod.safety_stock_level
        , prod.weight
        , prod.days_to_manufacture
        , prod.reorder_point

        -- boolean
        , prod.make_flag
        , prod.finished_goods_flag

        -- date & timestamp
        , prod.sell_start_date
        , prod.sell_end_date
        , prod.modified_date
        
        -- unique key
        , prod.row_guid

    FROM
        products AS prod
    LEFT JOIN
        subcategories AS sub ON prod.product_subcategory_id = sub.product_subcategory_id
    LEFT JOIN
        categories AS cat ON sub.product_category_id = cat.product_category_id
),

dim_products AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_sk,
        *
    FROM
        join_tables
)

SELECT * FROM dim_products
