SELECT
  payment_type,
  COUNT(DISTINCT order_id) AS orders,
  ROUND(SUM(payment_value), 2) AS total_paid,
  ROUND(SUM(payment_value) / COUNT(DISTINCT order_id), 2) AS avg_order_value,
  ROUND(100.0 * COUNT(DISTINCT order_id) / SUM(COUNT(DISTINCT order_id)) OVER (), 1) AS pct_of_orders
FROM order_payments
WHERE payment_type <> 'not_defined'
GROUP BY payment_type
ORDER BY orders DESC;