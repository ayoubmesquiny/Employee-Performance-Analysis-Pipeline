-- models/dimensions/compensation_dimension.sql
{{ config(materialized='table') }}

SELECT
    ROW_NUMBER() OVER (ORDER BY "StockOptionLevel", "HourlyRate", "MonthlyRate") AS compensation_id,
    "StockOptionLevel" AS stock_option_level,
    "HourlyRate" AS hourly_rate,
    "MonthlyRate" AS monthly_rate
FROM employees
GROUP BY "StockOptionLevel", "HourlyRate", "MonthlyRate"
