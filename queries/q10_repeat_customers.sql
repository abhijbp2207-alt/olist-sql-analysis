WITH customer_orders AS (
SELECT 
customer_unique_id,
COUNT(DISTINCT order_id)AS num_orders
FROM customers c 
JOIN  orders o ON o.customer_id=c.customer_id
GROUP BY customer_unique_id
)
SELECT
COUNT(*) AS total_customers,
SUM(CASE WHEN num_orders > 1 THEN 1 ELSE 0 END) AS repeat_customers,
ROUND(100.0*SUM(CASE WHEN num_orders>1 THEN 1 ELSE 0 END)/COUNT(*),1)AS repeat_pct
 FROM customer_orders;