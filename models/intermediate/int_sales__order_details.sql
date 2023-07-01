WITH sales_order_header AS (
    SELECT * FROM {{ ref('stg_sap__sales_order_header') }}
),

sales_order_details AS (
    SELECT * FROM {{ ref('stg_sap__sales_order_details') }}
),

credit_cards AS (
    SELECT * FROM {{ ref('stg_sap__credit_cards') }}
),

int_sales__order_details AS (
    SELECT
        sod.sales_order_detail_id
        , sod.sales_order_id
        , sod.product_id
        , soh.customer_id
        , sod.special_offer_id
        , soh.sales_person_id
        , soh.territory_id
        , soh.bill_to_address_id
        , soh.credit_card_id
        , cr.card_type
        , sod.unit_price
        , sod.unit_price_discount
        , sod.order_qty
        , soh.freight
        , soh.purchase_order_number
        , soh.revision_number
        , soh.status
        , soh.subtotal
        , soh.tax_amount
        , soh.total_due
        , soh.online_order_flag
        , soh.order_date
    FROM
        sales_order_details AS sod
    LEFT JOIN
        sales_order_header AS soh ON sod.sales_order_id = soh.sales_order_id
    LEFT JOIN
        credit_cards AS cr ON cr.credit_card_id = soh.credit_card_id
)
SELECT * FROM int_sales__order_details