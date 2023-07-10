WITH validation AS (
    SELECT
        COUNT(*) AS qty
    FROM {{ ref("dim_customers") }}
)
-- check if the table is not empty
SELECT
    *
FROM
    validation
WHERE
    qty = 0
