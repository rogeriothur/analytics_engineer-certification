WITH src_product AS (
    SELECT * FROM {{ source('sap', 'product') }}
),

products AS (
    SELECT
        -- primary key
        productid

        -- foreign keys
        , productmodelid
        , productsubcategoryid

        -- strings
        , productnumber
        , name 
        , class
        , color
        , size
        , sizeunitmeasurecode
        , weightunitmeasurecode
        , style
        , productline

        -- numeric
        , standardcost
        , listprice
        , safetystocklevel
        , weight
        , daystomanufacture
        , reorderpoint
        
        -- boolean
        , makeflag
        , finishedgoodsflag

        -- date & timestamp
        , TO_TIMESTAMP(sellstartdate) AS sellstartdate
        , TO_TIMESTAMP(sellenddate) AS sellenddate
        , TO_TIMESTAMP(MODIFIEDDATE) AS modifieddate

        -- unique key
        , rowguid
    FROM 
        {{ source('sap', 'product') }}
)
SELECT * FROM products