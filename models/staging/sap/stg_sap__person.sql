WITH src_person AS (
    SELECT * FROM {{ source('sap', 'person') }}
),

person AS (
    SELECT
        -- primary key
        businessentityid AS business_entity_id

        -- strings
        , persontype AS person_type
        , title
        , firstname AS first_name
        , middlename AS middle_name
        , lastname As last_name
        , suffix

        -- numeric
        , emailpromotion AS email_promotion

        -- boolean
        , namestyle AS name_style

        -- date & timestamp
        , TO_TIMESTAMP(MODIFIEDDATE) AS modified_date

        -- unique key
        , rowguid AS row_guid
    FROM
        src_person
)
SELECT * FROM person