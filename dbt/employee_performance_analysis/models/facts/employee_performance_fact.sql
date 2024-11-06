-- models/facts/employee_performance_fact.sql
{{ config(materialized='table') }}

WITH job AS (
    SELECT job_id, job_role, job_level, department
    FROM {{ ref('job_dimension') }}
),
satisfaction AS (
    SELECT satisfaction_id, job_satisfaction, relationship_satisfaction, 
           environment_satisfaction, work_life_balance
    FROM {{ ref('satisfaction_dimension') }}
),
compensation AS (
    SELECT compensation_id, stock_option_level, hourly_rate, monthly_rate
    FROM {{ ref('compensation_dimension') }}
)

SELECT
    "EmployeeNumber" AS employee_id,
    "PerformanceRating" AS performance_rating,
    "Attrition" AS attrition,
    "MonthlyIncome" AS monthly_income,
    "DailyRate" AS daily_rate,
    "YearsAtCompany" AS years_at_company,
    "YearsInCurrentRole" AS years_in_current_role,
    "YearsSinceLastPromotion" AS years_since_last_promotion,
    "YearsWithCurrManager" AS years_with_curr_manager,
    job.job_id,
    satisfaction.satisfaction_id,
    compensation.compensation_id
FROM employees
LEFT JOIN job 
    ON "JobRole" = job.job_role 
    AND "Department" = job.department
LEFT JOIN satisfaction 
    ON "JobSatisfaction" = satisfaction.job_satisfaction
    AND "RelationshipSatisfaction" = satisfaction.relationship_satisfaction
    AND "EnvironmentSatisfaction" = satisfaction.environment_satisfaction
    AND "WorkLifeBalance" = satisfaction.work_life_balance
LEFT JOIN compensation 
    ON "StockOptionLevel" = compensation.stock_option_level
    AND "HourlyRate" = compensation.hourly_rate
    AND "MonthlyRate" = compensation.monthly_rate
