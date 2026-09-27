WITH monthly AS (
SELECT 
DATE_TRUNC('month',o.order_purchase_timestamp)::date AS month,
SUM(oi.price)AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
)
SELECT 
month,
revenue,
ROUND(
SUM(revenue)OVER (ORDER BY month), 2) AS running_total

FROM monthly
ORDER BY month;
