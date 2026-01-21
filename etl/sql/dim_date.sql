CREATE OR REPLACE TABLE dim_date AS
WITH dates AS (
    SELECT *
    FROM generate_series(
        DATE '2023-08-01',
        DATE '2024-05-31',
        INTERVAL 1 DAY
    ) AS t(date)
)
SELECT
    date AS date_key,
    date,

    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    EXTRACT(DAY FROM date) AS day,

    STRFTIME(date, '%Y-%m') AS year_month,
    STRFTIME(date, '%A') AS day_name,
    STRFTIME(date, '%B') AS month_name,

    CASE
        WHEN EXTRACT(DOW FROM date) IN (0, 6) THEN TRUE
        ELSE FALSE
    END AS is_weekend
FROM dates;
