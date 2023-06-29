WITH src_product_category AS (
    SELECT * FROM {{ source('sap', 'productcategory') }}
),

product_categories AS (
    SELECT
        -- primary key
        productcategoryid AS product_category_id

        -- strings
        , name AS product_category_name

         -- date & timestamp
        , TO_TIMESTAMP(MODIFIEDDATE) AS modified_date

        -- unique key
        , rowguid AS row_guid
    FROM 
        src_product_category
)
SELECT * FROM product_categories