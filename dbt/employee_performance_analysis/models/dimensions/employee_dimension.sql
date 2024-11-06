-- models/dimensions/employee_dimension.sql
{{ config(materialized='table') }}

SELECT DISTINCT
    "EmployeeNumber" AS employee_id,
    "Age" AS age,
    "Gender" AS gender,
    "Education" AS education,
    "EducationField" AS education_field,
    "MaritalStatus" AS marital_status
FROM employees
