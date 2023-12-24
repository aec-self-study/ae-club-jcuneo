{{ config(
  materialized="view"
) }}

SELECT
    DATE_TRUNC(c.min_order_created_at, MONTH) AS month
   ,COUNT(c.id) AS count_customers
FROM {{ ref('customers') }} AS c
GROUP BY month
