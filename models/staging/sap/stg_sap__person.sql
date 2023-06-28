WITH src_person AS (
    SELECT * FROM {{ source('sap', 'person') }}
),

person AS (
    SELECT
        -- primary key
        businessentityid

        -- strings
        , persontype
        , title
        , firstname
        , middlename
        , lastname
        , suffix

        -- numeric
        , emailpromotion

        -- boolean
        , namestyle

        -- date & timestamp
        , TO_TIMESTAMP(MODIFIEDDATE) AS modifieddate

        -- unique key
        , rowguid
    FROM
        src_person
)
SELECT * FROM person