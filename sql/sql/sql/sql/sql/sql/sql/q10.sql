SELECT
    c.region,
    o.order_month,
    COUNT(*) AS number_of_orders,
    COUNT(DISTINCT o.customer_id) AS number_of_customers,
    SUM(o.amount) AS total_revenue,
    ROUND(AVG(o.amount), 2) AS average_revenue
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.status = 'completed'
GROUP BY c.region, o.order_month
ORDER BY c.region ASC, o.order_month ASC;
