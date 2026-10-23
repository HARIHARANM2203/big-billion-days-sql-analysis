
-- D1: Regional revenue validation
-- Include completed orders only.
-- Show regions with completed revenue greater than 80000.

SELECT
    c.region,
    SUM(o.amount) AS total_revenue
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE LOWER(TRIM(o.status)) = 'completed'
GROUP BY c.region
HAVING SUM(o.amount) > 80000
ORDER BY total_revenue DESC;
