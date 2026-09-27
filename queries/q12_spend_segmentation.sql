WITH customer_spend AS (
SELECT
c.customer_unique_id,
SUM(oi.price)AS total_spend
FROM customers c
JOIN orders o ON o.customer_id=c.customer_id
JOIN order_items oi ON oi.order_id=o.order_id
WHERE o.order_status ='delivered'
GROUP BY c.customer_unique_id
),
segmented AS (
SELECT 
customer_unique_id,
total_spend,
NTILE(4) OVER(ORDER BY total_spend DESC) AS spend_quartile
FROM customer_spend
)
SELECT 
spend_quartile,
COUNT(*) AS customers,
ROUND(SUM(total_spend),2)AS total_revenue,
ROUND(100.0*SUM(total_spend)/SUM(SUM(total_spend))OVER (),1) AS pct_of_revenue
FROM segmented
GROUP BY spend_quartile
ORDER BY spend_quartile;