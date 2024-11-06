-- models/dimensions/satisfaction_dimension.sql
{{ config(materialized='table') }}

SELECT
    ROW_NUMBER() OVER (ORDER BY "JobSatisfaction", "RelationshipSatisfaction", "EnvironmentSatisfaction", "WorkLifeBalance") AS satisfaction_id,
    "JobSatisfaction" AS job_satisfaction,
    "RelationshipSatisfaction" AS relationship_satisfaction,
    "EnvironmentSatisfaction" AS environment_satisfaction,
    "WorkLifeBalance" AS work_life_balance
FROM employees
GROUP BY "JobSatisfaction", "RelationshipSatisfaction", "EnvironmentSatisfaction", "WorkLifeBalance"
