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
100.0*(revenue-LAG(revenue) OVER(ORDER BY month))
/LAG(revenue)OVER(ORDER BY month),1
)
AS mom_growth_pct
FROM monthly
ORDER BY month;
