WITH src_product AS (
    SELECT
        -- PK
        productid

        -- FK
        , productmodelid
        , productsubcategoryid

        , name AS productname
        , productnumber
        , class
        , standardcost
        , listprice
        , safetystocklevel
        , size
        , sizeunitmeasurecode
        , weight
        , weightunitmeasurecode
        , color
        , style
        , sellenddate
        , daystomanufacture
        , productline
        , reorderpoint
        , makeflag
        , finishedgoodsflag
        , modifieddate	
        , rowguid
    FROM 
        {{ source('sap', 'product') }}
)
SELECT * FROM src_product