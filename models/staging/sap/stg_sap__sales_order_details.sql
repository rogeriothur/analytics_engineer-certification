WITH src_sales_order_detail AS (
    SELECT * FROM {{ source('sap', 'salesorderdetail') }}
),

sales_order_details AS (
    SELECT
        -- primary key
        salesorderdetailid AS sales_order_detail_id

        -- foreign keys
        , salesorderid AS sales_order_id
        , productid AS product_id
        , specialofferid AS special_offer_id

        -- strings
        , carriertrackingnumber AS carrier_tracking_number
        
        -- numeric
        , unitprice AS unit_price
        , unitpricediscount AS unit_price_discount
        , orderqty AS order_qty

        -- date & timestamp
        , TO_TIMESTAMP(MODIFIEDDATE) AS modified_date

        -- unique key
        , rowguid AS row_guid
    FROM 
        src_sales_order_detail
)
SELECT * FROM sales_order_details