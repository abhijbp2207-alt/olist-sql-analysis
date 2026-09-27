WITH seller_revenue AS(
SELECT 
s.seller_id,
s.seller_state,
SUM(oi.price) AS revenue,
COUNT (DISTINCT oi.order_id) AS orders
FROM order_items oi
JOIN sellers s ON s.seller_id = oi.seller_id
JOIN orders o ON o.order_id=oi.order_id
WHERE o.order_status='delivered'
GROUP BY s.seller_id, s.seller_state
)
SELECT 
seller_id,
seller_state,
revenue,
orders,
RANK() OVER(PARTITION BY seller_state ORDER BY revenue DESC) AS  rank_in_state
FROM seller_revenue
ORDER BY revenue DESC
LIMIT 10;