WITH src_product AS (
    SELECT * FROM {{ source('sap', 'product') }}
),

products AS (
    SELECT
        -- primary key
        productid AS product_id

        -- foreign keys
        , productmodelid AS product_model_id
        , productsubcategoryid AS product_subcategory_id

        -- strings
        , productnumber AS product_number
        , name AS product_name
        , class
        , color
        , size
        , sizeunitmeasurecode AS size_unit_measure_code
        , weightunitmeasurecode AS weight_unit_measure_code
        , style
        , productline AS product_line

        -- numeric
        , standardcost AS standard_cost
        , listprice AS list_price
        , safetystocklevel AS safety_stock_level
        , weight
        , daystomanufacture As days_to_manufacture
        , reorderpoint AS reorder_point
        
        -- boolean
        , makeflag AS make_flag
        , finishedgoodsflag AS finished_goods_flag

        -- date & timestamp
        , TO_TIMESTAMP(sellstartdate) AS sell_start_date
        , TO_TIMESTAMP(sellenddate) AS sell_end_date
        , TO_TIMESTAMP(MODIFIEDDATE) AS modified_date

        -- unique key
        , rowguid AS row_guid
    FROM 
        src_product
)
SELECT * FROM products