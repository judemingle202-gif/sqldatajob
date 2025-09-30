/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions.
-Focuses on roles with specified salaries in Germany.
- WHY? It reveals how different skills impact salary levels for data analysts and helps identify the most 
financially rewarding skills to acquire or improve.
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN 
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_location LIKE '%Germany%' AND 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25;

/*-- Analysis:
--Engineering Pays the Premium: The highest salaries (around €166k) are 
commanded by specialized Data Engineering, DevOps, and Cloud Infrastructure 
skills like Kafka, Terraform, BigQuery, and Redshift.

--Cloud Competence is a Differentiator: Expertise in major cloud platforms and 
their tools (e.g., GCP, BigQuery) drives a significant salary bump, separating 
high-earning analysts who can manage infrastructure from those who only analyze data.

-- Core Skills are Foundation, Not Top Salary Drivers: While foundational skills like SQL,
 Python, and Power BI are essential to getting hired (they are the most demanded), they 
 appear further down the high-salary list.
*/