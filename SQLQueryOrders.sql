--Join Customers and Orders Table for orders between "2025-01-01 to 2025-01-02" with active status.
SELECT 
	o.order_id,
	o.order_date,
	c.customer_id,
	c.full_name,
	c.email
FROM orders as o
JOIN customers as c
	ON o.customer_id = c.customer_id
WHERE o.order_date >=  '2025-01-01'
	AND o.order_date < '2025-01-02'
	AND c.status = 'ACTIVE'
ORDER BY 
	o.order_date DESC,
	o.order_id;


-- Orders placed on or after 2025-01-01 

SELECT
	order_id,
	customer_id,
	order_date,
	total_amount
FROM orders
WHERE order_date >= '2025-01-01'
ORDER BY order_date
LIMIT 100;


-- Average monthly order for high volume months with orders >1000 in  year 2025

WITH monthly_orders AS (
	SELECT
		DATE_TRUNC('month', order_date) As month_start,
		COUNT(*) AS total_orders,
		SUM(total_amount) AS total_revenue
	FROM orders
	WHERE order_date >= '2025-01-01'
	AND   order_date < '2026-01-01'
	GROUP BY DATE_TRUNC ('month', order_date)
),
high_volume_months AS (
	SELECT
		month_start,
		total_orders,
		total_revenue,
		total_revenue / NULLIF(total_orders, 0) AS avg_orders_value
	FROM monthly_orders
	WHERE total_orders > 1000
)
SELECT
	AVG(avg_orders_value) AS avg_order_value_in_busy_months
FROM high_volume_months;

--Join Orders with customers full name 

SELECT 
	o.order_id,
	o.order_date,
	c.full_name AS customer_name
FROM orders AS o
JOIN customers AS c
	ON o.customer_id = c.customer_id;


--Return non null user logins

SELECT COUNT(last_login_at) AS users_with_login
	FROM users;