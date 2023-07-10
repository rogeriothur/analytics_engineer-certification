WITH src_credit_card AS (
    SELECT * FROM {{ source('sap', 'creditcard') }}
),

credit_cards AS (
    SELECT
        -- primary key
        creditcardid AS credit_card_id

        -- strings
        , cardtype AS card_type
        
        -- numeric
        , cardnumber AS card_number
        , expmonth AS exp_month
        , expyear AS exp_year
    
        -- date & timestamp
        , TO_TIMESTAMP(MODIFIEDDATE) AS modified_date

    FROM
        src_credit_card
)

SELECT * FROM credit_cards