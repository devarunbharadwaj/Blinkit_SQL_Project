-- Section F: Order Analysis
-- Comprehensive operational analysis of Blinkit's order system


-- F1: Daily Order Volume Trend

SELECT 
    DATE(order_date) AS day,
    COUNT(*) AS total_orders
FROM blinkit_orders
GROUP BY day
ORDER BY day;


-- F2: Most Popular Payment Methods

SELECT 
    payment_method,
    COUNT(*) AS total_orders
FROM blinkit_orders
GROUP BY payment_method
ORDER BY total_orders DESC;


-- F3: On-time Delivery Rate

SELECT 
    ROUND(
        SUM(CASE WHEN delivery_status = 'Delivered' THEN 1 END)::numeric
        / COUNT(*) * 100, 2
    ) AS on_time_delivery_rate
FROM blinkit_orders;

-- F4: Orders by Delivery Partner

SELECT
    delivery_partner_id,
    COUNT(*) AS orders_handled
FROM blinkit_orders
GROUP BY delivery_partner_id
ORDER BY orders_handled DESC;


-- F5: Average Delivery Delay (Actual - Promised)

SELECT
    ROUND(AVG(actual_delivery_time - promised_delivery_time), 2) AS avg_delay_minutes
FROM blinkit_orders;


-- F6: Top Stores by Order Volume

SELECT
    store_id,
    COUNT(*) AS total_orders
FROM blinkit_orders
GROUP BY store_id
ORDER BY total_orders DESC
LIMIT 10;


-- F7: Order Value Distribution by Customer Segment

SELECT
    c.customer_segment,
    ROUND(AVG(o.order_total), 2) AS avg_order_value
FROM blinkit_orders o
JOIN blinkit_customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY avg_order_value DESC;


-- F8: Delivery Efficiency by Distance Category

SELECT
    CASE
        WHEN d.distance_km < 2 THEN '0–2 km'
        WHEN d.distance_km < 5 THEN '2–5 km'
        WHEN d.distance_km < 10 THEN '5–10 km'
        ELSE '10+ km'
    END AS distance_range,
    ROUND(AVG(d.delivery_time_minutes), 2) AS avg_delivery_time
FROM blinkit_delivery_performance d
GROUP BY distance_range
ORDER BY avg_delivery_time;


-- F9: Orders by Hour (Peak Hours)

SELECT
    EXTRACT(HOUR FROM order_date) AS hour_of_day,
    COUNT(*) AS total_orders
FROM blinkit_orders
GROUP BY hour_of_day
ORDER BY hour_of_day;


-- F10: Repeat vs One-time Customers

SELECT
    CASE WHEN c.total_orders > 1 THEN 'Repeat Customer'
         ELSE 'One-time Customer' END AS customer_type,
    COUNT(*) AS customer_count
FROM blinkit_customers c
GROUP BY customer_type
ORDER BY customer_count DESC;
