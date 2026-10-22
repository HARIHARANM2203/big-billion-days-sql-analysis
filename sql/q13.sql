SELECT
    r.rep_name,
    o.order_month,
    r.monthly_target,
    SUM(o.amount) AS revenue,
    CASE
        WHEN SUM(o.amount) < r.monthly_target
            THEN 'Below Target'
        WHEN SUM(o.amount) < r.monthly_target * 1.1
            THEN 'On Target'
        ELSE 'Above Target'
    END AS performance_tier
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id
INNER JOIN reps AS r
    ON c.rep_id = r.rep_id
WHERE o.status = 'completed'
GROUP BY
    r.rep_id,
    r.rep_name,
    o.order_month,
    r.monthly_target
ORDER BY r.rep_name ASC, o.order_month ASC;
