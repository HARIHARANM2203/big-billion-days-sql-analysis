SELECT
    COUNT(*) AS completed_orders,
    SUM(amount) AS total_completed_amount
FROM orders
WHERE LOWER(TRIM(status)) = 'completed';
