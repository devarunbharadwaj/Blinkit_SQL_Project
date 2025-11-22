-- A1 Monthly Delivery Time Trend
SELECT 
    DATE_TRUNC('month', promised_time) AS month,
    AVG(delivery_time_minutes) AS avg_delivery_time
FROM blinkit_delivery_performance
GROUP BY month
ORDER BY month;

-- A2 Delivery Time by Partner
SELECT 
    delivery_partner_id,
    AVG(delivery_time_minutes) AS avg_delivery_time
FROM blinkit_delivery_performance
GROUP BY delivery_partner_id
ORDER BY avg_delivery_time;

-- A3 Delay Rate Trend
SELECT 
    DATE_TRUNC('month', promised_time) AS month,
    ROUND(SUM(CASE WHEN delivery_status='Delayed' THEN 1 END)::numeric / COUNT(*) * 100, 2) AS delay_rate
FROM blinkit_delivery_performance
GROUP BY month
ORDER BY month;

-- A4 Delivery Time vs Distance
SELECT 
    distance_km,
    AVG(delivery_time_minutes) AS avg_delivery_time
FROM blinkit_delivery_performance
GROUP BY distance_km
ORDER BY distance_km;
