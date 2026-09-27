SELECT 
CASE 
WHEN o.order_delivered_customer_date>o.order_estimated_delivery_date THEN 'LATE'
ELSE 'On time'
END AS delivery_status,
COUNT(*) AS orders,
ROUND(AVG(r.review_score),2) AS avg_review_score
FROM orders o
JOIN order_reviews r ON r.order_id=o.order_id
WHERE o.order_status='delivered'
AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 1;	