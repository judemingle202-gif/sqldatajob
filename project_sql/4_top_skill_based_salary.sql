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
- Top-tier salaries (~€166K) are linked to cloud, database, and
 infrastructure tools (Kafka, BigQuery, NoSQL, Redshift, Terraform).

- Big data & distributed computing skills (Spark, Databricks, PySpark,
 GCP) form the second-highest salary group (€120K–€138K).

- Programming & analytics staples (Python, Pandas, NumPy, Git) and
 BI tools (Power BI) remain valuable, but average salaries are closer
  to €100K, showing less premium compared to cloud/data engineering 
  skills.
*/