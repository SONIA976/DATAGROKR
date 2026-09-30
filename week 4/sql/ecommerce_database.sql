-- ============================================================
-- Week 4 Mini Project: SQL E-commerce Report
-- Name: Sonia Joshi
-- USN: 1NT23CS238
-- ============================================================


-- ============================================================
-- DATABASE CREATION
-- ============================================================

CREATE DATABASE IF NOT EXISTS ecommerce_db;

USE ecommerce_db;


-- ============================================================
-- TABLE CREATION
-- ============================================================

-- Customer table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50),
    signup_date DATE
);


-- Product table
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0
);


-- Order table
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


-- Order items table
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(5,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- ============================================================
-- ALTER TABLE
-- ============================================================

ALTER TABLE products
ADD COLUMN IF NOT EXISTS description VARCHAR(255);


-- ============================================================
-- SAMPLE DATA
-- ============================================================

-- Customers
INSERT INTO customers
(customer_id, customer_name, email, city, signup_date)
VALUES
(1, 'Sonia Joshi', 'sonia@gmail.com', 'Bangalore', '2025-01-15'),
(2, 'Rahul Sharma', 'rahul@gmail.com', 'Mumbai', '2025-02-20'),
(3, 'Ananya Rao', 'ananya@gmail.com', 'Mysore', '2025-03-10'),
(4, 'Rohan Kumar', 'rohan@gmail.com', NULL, '2025-03-25'),
(5, 'Priya Singh', 'priya@gmail.com', 'Delhi', '2025-04-05'),
(6, 'Arjun Patel', 'arjun@gmail.com', 'Chennai', '2025-04-18'),
(7, 'Neha Gupta', 'neha@gmail.com', NULL, '2025-05-02'),
(8, 'Karan Mehta', 'karan@gmail.com', 'Hyderabad', '2025-05-15');


-- Products
INSERT INTO products
(product_id, product_name, category, price, stock_quantity, description)
VALUES
(101, 'Laptop', 'Electronics', 65000.00, 10, 'High performance laptop'),
(102, 'Smartphone', 'Electronics', 30000.00, 25, 'Latest smartphone model'),
(103, 'Headphones', 'Electronics', 2500.00, 50, 'Wireless headphones'),
(104, 'Keyboard', 'Accessories', 1500.00, 40, 'Mechanical keyboard'),
(105, 'Mouse', 'Accessories', 800.00, 60, 'Wireless mouse'),
(106, 'Backpack', 'Travel', 2200.00, 30, 'Water resistant backpack'),
(107, 'Watch', 'Accessories', 5000.00, 20, NULL),
(108, 'Tablet', 'Electronics', 22000.00, 15, NULL);


-- Orders
INSERT INTO orders
(order_id, customer_id, order_date, total_amount, status)
VALUES
(1001, 1, '2025-06-01', 67500.00, 'Delivered'),
(1002, 2, '2025-06-03', 30000.00, 'Delivered'),
(1003, 3, '2025-06-05', 4000.00, 'Shipped'),
(1004, 1, '2025-06-10', 22000.00, 'Delivered'),
(1005, 4, '2025-06-12', 5000.00, 'Pending'),
(1006, 5, '2025-06-15', 6800.00, 'Delivered'),
(1007, 6, '2025-06-18', 1500.00, 'Shipped'),
(1008, 7, '2025-06-20', 5200.00, 'Pending'),
(1009, 8, '2025-06-22', 32500.00, 'Delivered'),
(1010, 2, '2025-06-25', 3000.00, 'Cancelled'),
(1011, 3, '2025-07-01', 22000.00, 'Delivered'),
(1012, 5, '2025-07-03', 800.00, 'Shipped');


-- Order Items
INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price, discount)
VALUES
(1, 1001, 101, 1, 65000.00, 0.00),
(2, 1001, 105, 1, 800.00, NULL),
(3, 1002, 102, 1, 30000.00, 0.00),
(4, 1003, 103, 1, 2500.00, 5.00),
(5, 1003, 104, 1, 1500.00, NULL),
(6, 1004, 108, 1, 22000.00, 0.00),
(7, 1005, 107, 1, 5000.00, NULL),
(8, 1006, 106, 2, 2200.00, 0.00),
(9, 1006, 103, 1, 2500.00, 10.00),
(10, 1007, 104, 1, 1500.00, 0.00),
(11, 1008, 107, 1, 5000.00, 5.00),
(12, 1009, 102, 1, 30000.00, 0.00),
(13, 1009, 103, 1, 2500.00, NULL),
(14, 1010, 105, 2, 800.00, 0.00),
(15, 1011, 108, 1, 22000.00, 0.00),
(16, 1012, 105, 1, 800.00, NULL);


-- ============================================================
-- 35 SQL QUERIES
-- ============================================================

-- Query 1: Basic SELECT
SELECT * FROM customers;


-- Query 2: WHERE
SELECT *
FROM customers
WHERE city = 'Bangalore';


-- Query 3: ORDER BY
SELECT product_name, price
FROM products
ORDER BY price DESC;


-- Query 4: LIMIT
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 3;


-- Query 5: Column Aliases
SELECT
    product_name AS Product,
    price AS Price,
    stock_quantity AS Stock
FROM products;


-- Query 6: IS NULL
SELECT customer_name, city
FROM customers
WHERE city IS NULL;


-- Query 7: COALESCE
SELECT
    customer_name,
    COALESCE(city, 'City Not Provided') AS city
FROM customers;


-- Query 8: NULLIF
SELECT
    product_name,
    NULLIF(stock_quantity, 0) AS available_stock
FROM products;


-- Query 9: COUNT
SELECT COUNT(*) AS total_customers
FROM customers;


-- Query 10: SUM
SELECT SUM(total_amount) AS total_sales
FROM orders;


-- Query 11: AVG
SELECT AVG(total_amount) AS average_order_amount
FROM orders;


-- Query 12: GROUP BY
SELECT
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status;


-- Query 13: HAVING
SELECT
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status
HAVING COUNT(*) > 2;


-- Query 14: INNER JOIN
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id;


-- Query 15: LEFT JOIN
SELECT
    c.customer_name,
    o.order_id,
    o.total_amount
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;


-- Query 16: RIGHT JOIN
SELECT
    c.customer_name,
    o.order_id,
    o.total_amount
FROM customers c
RIGHT JOIN orders o
    ON c.customer_id = o.customer_id;


-- Query 17: FULL OUTER JOIN equivalent using UNION
SELECT
    c.customer_name,
    o.order_id,
    o.total_amount
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id

UNION

SELECT
    c.customer_name,
    o.order_id,
    o.total_amount
FROM customers c
RIGHT JOIN orders o
    ON c.customer_id = o.customer_id;


-- Query 18: CASE WHEN
SELECT
    product_name,
    price,
    CASE
        WHEN price >= 30000 THEN 'Expensive'
        WHEN price >= 5000 THEN 'Medium'
        ELSE 'Affordable'
    END AS price_category
FROM products;


-- Query 19: String Functions
SELECT
    product_name,
    UPPER(product_name) AS uppercase_name,
    LENGTH(product_name) AS name_length
FROM products;


-- Query 20: Date Functions
SELECT
    order_id,
    order_date,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month
FROM orders;


-- Query 21: Customer Spending
SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;


-- Query 22: Top 5 Products by Price
SELECT
    product_name,
    category,
    price
FROM products
ORDER BY price DESC
LIMIT 5;


-- Query 23: Top-Selling Products
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_units_sold
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_units_sold DESC;


-- Query 24: Product Revenue
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC;


-- Query 25: Order Trends by Month
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_sales
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;


-- Query 26: Customer Order Count
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;


-- Query 27: Average Spending per Customer
SELECT
    c.customer_name,
    AVG(o.total_amount) AS average_order_value
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY average_order_value DESC;


-- Query 28: Customers Spending More Than ₹20,000
SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) > 20000
ORDER BY total_spent DESC;


-- Query 29: Low Stock Products
SELECT
    product_name,
    stock_quantity
FROM products
WHERE stock_quantity < 20
ORDER BY stock_quantity ASC;


-- Query 30: Order Status Summary
SELECT
    status,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_sales
FROM orders
GROUP BY status
ORDER BY total_sales DESC;


-- Query 31: Products That Have Never Been Ordered
SELECT
    p.product_name,
    p.category
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;


-- Query 32: Products Ordered More Than Once
SELECT
    p.product_name,
    COUNT(oi.order_item_id) AS times_ordered
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(oi.order_item_id) > 1
ORDER BY times_ordered DESC;


-- Query 33: Discount Handling with COALESCE
SELECT
    order_item_id,
    product_id,
    unit_price,
    COALESCE(discount, 0) AS discount_percent,
    unit_price - (unit_price * COALESCE(discount, 0) / 100) AS final_price
FROM order_items;


-- Query 34: Orders Above Average
SELECT
    order_id,
    customer_id,
    total_amount
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM orders
)
ORDER BY total_amount DESC;


-- Query 35: Customer and Product Purchase Details
SELECT
    c.customer_name,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
ORDER BY c.customer_name;


-- ============================================================
-- END OF WEEK 4 SQL PROJECT
-- ============================================================