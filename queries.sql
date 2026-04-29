-- 1. Get all customers
SELECT * FROM Customers;

-- 2. Customers from a specific city
SELECT * FROM Customers
WHERE city = 'Delhi';

-- 3. Total orders per customer
SELECT customer_id, COUNT(*) AS total_orders
FROM Orders
GROUP BY customer_id;

-- 4. Total amount spent by each customer
SELECT customer_id, SUM(amount) AS total_spent
FROM Orders
GROUP BY customer_id;

-- 5. Customers who spent more than 5000
SELECT customer_id, SUM(amount) AS total_spent
FROM Orders
GROUP BY customer_id
HAVING SUM(amount) > 5000;

-- 6. Inner Join: Orders with customer names
SELECT c.name, o.order_id, o.amount
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id;

-- 7. Left Join: All customers with orders (including no orders)
SELECT c.name, o.order_id
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id;

-- 8. Find highest order amount
SELECT MAX(amount) AS highest_order
FROM Orders;

-- 9. Subquery: Customers with above average spending
SELECT customer_id
FROM Orders
GROUP BY customer_id
HAVING SUM(amount) > (
    SELECT AVG(total)
    FROM (
        SELECT SUM(amount) AS total
        FROM Orders
        GROUP BY customer_id
    ) AS temp
);

-- 10. Top 3 customers by spending
SELECT customer_id, SUM(amount) AS total_spent
FROM Orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 3;

-- 11. Window Function: Rank customers by spending
SELECT customer_id,
       SUM(amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM Orders
GROUP BY customer_id;

-- 12. Find products never ordered
SELECT p.product_name
FROM Products p
LEFT JOIN Order_Items oi
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- 13. Total revenue per product
SELECT p.product_name, SUM(oi.quantity * p.price) AS revenue
FROM Products p
JOIN Order_Items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name;

-- 14. Orders in last 30 days
SELECT *
FROM Orders
WHERE order_date >= CURRENT_DATE - INTERVAL 30 DAY;

-- 15. Average order value
SELECT AVG(amount) AS avg_order_value
FROM Orders;
