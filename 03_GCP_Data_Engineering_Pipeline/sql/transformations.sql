CREATE OR REPLACE TABLE
`durable-path-497100-c5.analytics_pipeline.cleaned_customer_sales`
AS

SELECT
    string_field_1 AS product_name,

    SAFE_CAST(string_field_2 AS NUMERIC)
    AS quantity_ordered,

    SAFE_CAST(string_field_3 AS NUMERIC)
    AS price_each,

    SAFE.PARSE_DATETIME(
        '%m/%d/%y %H:%M',
        string_field_4
    ) AS order_datetime,

    SAFE_CAST(string_field_2 AS NUMERIC) *
    SAFE_CAST(string_field_3 AS NUMERIC)
    AS revenue

FROM `durable-path-497100-c5.analytics_pipeline.customer_sales`

WHERE string_field_1 != 'Product';
