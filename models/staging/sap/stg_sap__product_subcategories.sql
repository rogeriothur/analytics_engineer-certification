WITH src_product_subcategory AS (
    SELECT * FROM {{ source('sap', 'productsubcategory') }}
),

product_subcategories AS (
    SELECT
        -- primary key
        productsubcategoryid AS product_subcategory_id

        -- foreing key
        , productcategoryid AS product_category_id
        
        -- strings
        , name AS product_subcategory_name

         -- date & timestamp
        , TO_TIMESTAMP(MODIFIEDDATE) AS modified_date

        -- unique key
        , rowguid AS row_guid
    FROM 
        src_product_subcategory
)
SELECT * FROM product_subcategories