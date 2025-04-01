


{{ config(materialized='table') }}

WITH customer_sales AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(s.quantity * s.price) AS total_spent,
        COUNT(s.sale_id) AS total_purchases
    FROM 
        {{ ref('customer') }} c
    JOIN 
        {{ ref('sales') }} s
    ON 
        c.customer_id = s.customer_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name
)

SELECT * FROM customer_sales;