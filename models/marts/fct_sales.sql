WITH customers AS (
    SELECT * FROM {{ ref('dim_customers') }}
),

locations AS (
    SELECT * FROM {{ ref('dim_locations') }}
),

products AS (
    SELECT * FROM {{ ref('dim_produtcs') }}
),

sales_reasons AS (
    SELECT * FROM {{ ref('dim_sales_reasons') }}
),

sales_order_details AS (
    SELECT * FROM {{ ref('int_sales__order_details') }}
),

join_tables AS (
    SELECT
        sod.sales_order_detail_id
        , sod.sales_order_id
        , c.customer_sk AS customer_fk
        , l.location_sk AS location_fk
        , p.product_sk AS product_fk
        , s.sales_order_sk AS sales_reason_sk
        , s.sales_reason_name
        , sod.special_offer_id
        , sod.credit_card_id
        , sod.card_type
        , c.customer
        , sod.unit_price
        , sod.unit_price_discount
        , sod.order_qty
        , sod.freight
        , sod.status
        , sod.subtotal
        , sod.tax_amount
        , sod.total_due
        , sod.order_date
        , l.city
        , l.state_province_name
        , l.country_region_name
        , p.product_name
        , p.product_number
    FROM
        sales_order_details AS sod
    LEFT JOIN
        customers AS c ON sod.customer_id = c.customer_id
    LEFT JOIN
        locations AS l ON sod.bill_to_address_id = l.address_id
    LEFT JOIN
        products AS p ON sod.product_id = p.product_id
    LEFT JOIN
        sales_reasons AS s ON sod.sales_order_id = s.sales_order_id
),

fct_sales AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['sales_order_detail_id', 'sales_order_id']) }} AS sales_sk
        , *
    FROM
        join_tables
)

SELECT * FROM fct_sales
