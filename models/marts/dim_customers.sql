{{ config(materialized="table") }}

WITH customers AS (
    SELECT * FROM {{ ref('stg_sap__customers') }}
),

person AS (
    SELECT * FROM {{ ref('stg_sap__person') }}
),

dim_customers AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} AS customer_sk
        , c.customer_id
        , c.person_id
        , c.store_id
        , c.territory_id
        , p.person_type
        , CONCAT_WS(' ', COALESCE(p.title, ''), p.first_name, p.last_name) AS customer
        , p.email_promotion

    FROM
        customers AS c
    LEFT JOIN
        person AS p ON c.person_id = p.business_entity_id
)

SELECT * FROM dim_customers