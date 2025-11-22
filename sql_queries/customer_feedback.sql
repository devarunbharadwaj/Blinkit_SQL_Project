-- E1 Rating Distribution
SELECT
    rating,
    COUNT(*) AS rating_count
FROM blinkit_customer_feedback
GROUP BY rating
ORDER BY rating;

-- E2 Avg Rating Over Time
SELECT 
    DATE_TRUNC('month', feedback_date) AS month,
    ROUND(AVG(rating), 2) AS avg_rating
FROM blinkit_customer_feedback
GROUP BY month
ORDER BY month;

-- E3 Sentiment by Category
SELECT
    feedback_category,
    COUNT(CASE WHEN sentiment='Neutral' THEN 1 END) AS neutral_reviews,
    COUNT(CASE WHEN sentiment='Positive' THEN 1 END) AS positive_reviews,
    COUNT(CASE WHEN sentiment='Negative' THEN 1 END) AS negative_reviews
FROM blinkit_customer_feedback
GROUP BY feedback_category;

-- E4 Top Negative Feedback Issues
SELECT
    feedback_category,
    COUNT(*) AS negative_count
FROM blinkit_customer_feedback
WHERE sentiment = 'Negative'
GROUP BY feedback_category
ORDER BY negative_count DESC
LIMIT 10;

-- E5 Avg Rating by Customer Segment
SELECT
    c.customer_segment,
    ROUND(AVG(f.rating),2) AS avg_rating
FROM blinkit_customer_feedback f
JOIN blinkit_customers c
ON f.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY avg_rating DESC;

-- E6 Total Feedback Volume Trend
SELECT
    DATE_TRUNC('month', feedback_date) AS month,
    COUNT(*) AS total_feedback
FROM blinkit_customer_feedback
GROUP BY month
ORDER BY month;
