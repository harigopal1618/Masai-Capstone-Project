CREATE DATABASE mama_earth_import;
USE mama_earth_import;

-- Task 1 - Create Schema

CREATE TABLE customers (
customer_id VARCHAR(10) PRIMARY KEY,
name VARCHAR(50) NOT NULL,
city VARCHAR(50) NOT NULL,
city_tier INT NOT NULL,
signup_date DATE NOT NULL,
acquisition_source VARCHAR(20) NOT NULL
);

CREATE TABLE products (
product_id VARCHAR(10) PRIMARY KEY,
product_name VARCHAR(100) NOT NULL,
category VARCHAR(30) NOT NULL,
price DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders (
order_id VARCHAR(10) PRIMARY KEY,
customer_id VARCHAR(10) NOT NULL,
product_id VARCHAR(10) NOT NULL,
order_date DATE NOT NULL,
quantity INT NOT NULL,
discount_pct INT,
payment_method VARCHAR(10) NOT NULL,
rating INT,
returned INT NOT NULL DEFAULT 0,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

SET GLOBAL local_infile = 1;

-- Task 2 - Load Seed Data

LOAD DATA LOCAL INFILE 'D:\\masai material\\capstone project\\customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES; 

LOAD DATA LOCAL INFILE 'D:\\masai material\\capstone project\\products.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES; 

LOAD DATA LOCAL INFILE 'D:\\masai material\\capstone project\\orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES; 

UPDATE orders SET discount_pct = NULL WHERE discount_pct = '';
UPDATE orders SET rating = NULL WHERE rating = '';

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;

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



