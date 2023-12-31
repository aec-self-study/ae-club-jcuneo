{{ config(
  materialized="table"
) }}

WITH orders_by_cust AS (
  SELECT
    customer_id
   ,COUNT(DISTINCT id) AS count_orders
   ,MIN(created_at) AS min_order_created_at
  FROM {{ source('coffee_shop', 'orders') }}
  GROUP BY customer_id
)

SELECT
  c.id
 ,c.name
 ,c.email
 ,o.count_orders
 ,o.min_order_created_at
FROM {{ source('coffee_shop', 'customers') }} AS c
  LEFT JOIN orders_by_cust AS o
    ON c.id = o.customer_id
