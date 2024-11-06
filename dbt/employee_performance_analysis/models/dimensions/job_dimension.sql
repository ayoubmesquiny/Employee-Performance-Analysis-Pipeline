-- models/dimensions/job_dimension.sql
{{ config(materialized='table') }}

SELECT
    ROW_NUMBER() OVER (ORDER BY "JobRole", "JobLevel", "Department") AS job_id,
    "JobRole" AS job_role,
    "JobLevel" AS job_level,
    "Department" AS department
FROM employees
GROUP BY "JobRole", "JobLevel", "Department"
