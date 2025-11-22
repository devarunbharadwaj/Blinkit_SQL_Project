-- D1 Customer Segment Distribution
SELECT 
    customer_segment,
    COUNT(*) AS customer_count
FROM blinkit_customers
GROUP BY customer_segment
ORDER BY customer_count DESC;

-- D2 Average Order Value per Segment
SELECT
    customer_segment,
    ROUND(AVG(avg_order_value),2) AS avg_aov
FROM blinkit_customers
GROUP BY customer_segment;

-- D3 Monthly New Customers
SELECT
    DATE_TRUNC('month', registration_date) AS month,
    COUNT(*) AS new_customers
FROM blinkit_customers
GROUP BY month
ORDER BY month;

-- D4 Top Areas by Order Volume
SELECT
    area,
    SUM(total_orders) AS total_orders
FROM blinkit_customers
GROUP BY area
ORDER BY total_orders DESC
LIMIT 10;

-- D5 Revenue Potential by Segment
SELECT
    customer_segment,
    ROUND(SUM(total_orders * avg_order_value),2) AS revenue_potential
FROM blinkit_customers
GROUP BY customer_segment
ORDER BY revenue_potential DESC;
