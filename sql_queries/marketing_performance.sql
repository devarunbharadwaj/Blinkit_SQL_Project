-- B1 Monthly Spend vs Revenue
SELECT
    DATE_TRUNC('month', date) AS month,
    SUM(spend) AS total_spend,
    SUM(revenue_generated) AS total_revenue
FROM blinkit_marketing_performance
GROUP BY month
ORDER BY month;

-- B2 Channel Performance
SELECT
    channel,
    ROUND(SUM(clicks)::numeric / NULLIF(SUM(impressions),0) * 100, 2) AS ctr,
    ROUND(SUM(conversions)::numeric / NULLIF(SUM(clicks),0) * 100, 2) AS cvr,
    ROUND(SUM(revenue_generated)::numeric / NULLIF(SUM(spend),0), 2) AS roas
FROM blinkit_marketing_performance
GROUP BY channel;

-- B3 Top Campaigns by ROAS
SELECT
    campaign_name,
    ROUND(SUM(revenue_generated)::numeric / NULLIF(SUM(spend),0), 2) AS roas
FROM blinkit_marketing_performance
GROUP BY campaign_name
ORDER BY roas DESC
LIMIT 10;

-- B4 Target Segment Revenue
SELECT
    target_segment,
    SUM(revenue_generated) AS revenue
FROM blinkit_marketing_performance
GROUP BY target_segment;
