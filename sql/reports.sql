-- Task 3(a) - Order Totals

SELECT 
    COUNT(*) AS total_orders,
    
    SUM(quantity * price * (1 - COALESCE(discount_pct, 0) / 100.0)) AS total_revenue,
    
    AVG(quantity * price * (1 - COALESCE(discount_pct, 0) / 100.0)) AS average_order_value
FROM 
    orders
JOIN 
    products ON orders.product_id = products.product_id;
    
-- Task 3(b) - COUNT(*) vs COUNT(column)
    
    SELECT 
    COUNT(*) AS total_rows,
    COUNT(rating) AS non_null_ratings,
    (COUNT(*) - COUNT(rating)) AS difference
FROM orders;

-- Task 3(c) - Left Jopin with genuine zero match row

SELECT
    c.customer_id,
    c.name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.name
HAVING COUNT(o.order_id) = 0;

SELECT
    c.customer_id,
    c.name
FROM customers c
WHERE c.customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM orders
);

-- Task 3(d) - Group By + Having

SELECT
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(CASE
        WHEN o.returned = 1 THEN 1
        ELSE 0
    END) AS returned_orders,
    ROUND(
        100.0 * SUM(CASE
            WHEN o.returned = 1 THEN 1
            ELSE 0
        END) / COUNT(o.order_id),
        1
    ) AS return_rate_pct
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.city
HAVING return_rate_pct > 20
ORDER BY return_rate_pct DESC;

-- Task 3(e) - Ranking with ORDER BY + LIMIT / OFFSET

SELECT
    c.customer_id,
    c.name,
    ROUND(
        SUM(
            p.price * o.quantity *
            (1 - COALESCE(o.discount_pct, 0) / 100.0)
        ),
        2
    ) AS total_spend
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.name
ORDER BY
    total_spend DESC,
    c.customer_id ASC
-- LIMIT 5;       -- ORDER BY total_spend DESC, customer_id ASC ensures a consistent ranking by sorting customers by spending and using customer_id to break ties when their spending is equal.
LIMIT 3 OFFSET 2;

-- Task 3(f) - Three table join with GROUP BY

SELECT
    p.category,
    COUNT(o.order_id) AS order_count,
    ROUND(
        SUM(
            p.price * o.quantity *
            (1 - COALESCE(o.discount_pct, 0) / 100.0)
        ),
        2
    ) AS category_revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY
    p.category
ORDER BY
    category_revenue DESC;

-- Task 3(g) - Names starting with A

SELECT
    customer_id,
    name,
    city
FROM customers
WHERE name LIKE 'A%'
ORDER BY name ASC;

-- Task 3(h) - DISTINCT acquisition source

SELECT DISTINCT
    acquisition_source
FROM customers
ORDER BY acquisition_source ASC;

-- Task 3(i) - ALTER TABLE + UPDATE WITH CASE

ALTER TABLE customers
ADD COLUMN loyalty_tier VARCHAR(10);

UPDATE customers
SET loyalty_tier = CASE
    WHEN city_tier = 1 THEN 'Gold'
    ELSE 'Silver'
END;

SELECT loyalty_tier, COUNT(*) FROM customers GROUP BY loyalty_tier;