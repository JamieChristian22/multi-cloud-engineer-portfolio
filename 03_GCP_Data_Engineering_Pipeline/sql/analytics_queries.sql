-- =====================================================
-- CUSTOMER SALES ANALYTICS QUERIES
-- Project: GCP BigQuery Analytics Pipeline
-- Author: Jamie Christian
-- =====================================================

SELECT 
    SUM(
        SAFE_CAST(string_field_2 AS NUMERIC) *
        SAFE_CAST(string_field_3 AS NUMERIC)
    ) AS total_revenue
FROM `durable-path-497100-c5.analytics_pipeline.customer_sales`
WHERE string_field_2 != 'Quantity Ordered';

SELECT
    string_field_1 AS product_name,
    SUM(
        SAFE_CAST(string_field_2 AS NUMERIC) *
        SAFE_CAST(string_field_3 AS NUMERIC)
    ) AS total_sales
FROM `durable-path-497100-c5.analytics_pipeline.customer_sales`
WHERE string_field_1 != 'Product'
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    EXTRACT(
        MONTH FROM SAFE.PARSE_DATETIME(
            '%m/%d/%y %H:%M',
            string_field_4
        )
    ) AS month,

    SUM(
        SAFE_CAST(string_field_2 AS NUMERIC) *
        SAFE_CAST(string_field_3 AS NUMERIC)
    ) AS monthly_revenue

FROM `durable-path-497100-c5.analytics_pipeline.customer_sales`

WHERE string_field_4 != 'Order Date'

GROUP BY month
ORDER BY month;
