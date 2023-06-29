WITH src_sales_order_header AS (
    SELECT * FROM {{ source('sap', 'salesorderheader') }}
),

sales_order_header AS (
    SELECT
        -- primary key
        salesorderid AS sales_order_id

        -- foreign keys
        , customerid AS customer_id
        , salespersonid AS sales_person_id
        , territoryid AS territory_id
        , billtoaddressid AS bill_to_address_id
        , shiptoaddressid AS ship_to_address_id
        , shipmethodid AS ship_method_id
        , creditcardid AS credit_card_id
        , currencyrateid AS currency_rate_id

        -- strings
        , accountnumber AS account_number
        , creditcardapprovalcode AS creditcard_approval_code
        

        -- numeric
        , freight
        , purchaseordernumber AS purchase_order_number
        , revisionnumber AS revision_number
        , status
        , subtotal
        , taxamt AS tax_amount
        , totaldue AS total_due
        
        -- boolean
        , onlineorderflag AS online_order_flag

        -- date & timestamp
        , TO_TIMESTAMP(duedate) AS due_date
        , TO_TIMESTAMP(orderdate) AS order_date
        , TO_TIMESTAMP(shipdate) AS ship_date
        , TO_TIMESTAMP(MODIFIEDDATE) AS modified_date

        -- unique key
        , rowguid AS row_guid
    FROM 
        src_sales_order_header
)
SELECT * FROM sales_order_header