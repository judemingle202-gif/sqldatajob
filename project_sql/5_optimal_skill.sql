/*
Question: What are the most in-demand skills to learn 
- Identify skills in high demand and associated with high salaries for Data Analyst roles.
- Combine insights from previous queries on in-demand skills and top-paying skills
- WHY? Targets skills that offer job security and financial reward, guiding skill
 development for aspiring data analysts in Germany.
*/
WITH in_demand_skills AS(
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN 
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_location LIKE '%Germany%' AND 
    job_title_short = 'Data Analyst'
GROUP BY 
    skills_dim.skill_id

), average_salaries AS (

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
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
    skills_dim.skill_id
)

SELECT
    in_demand_skills.skill_id,
    in_demand_skills.skills,
    in_demand_skills.demand_count,
    average_salaries.avg_salary
FROM 
    in_demand_skills
INNER JOIN 
    average_salaries ON in_demand_skills.skill_id = average_salaries.skill_id
ORDER BY 
    in_demand_skills.demand_count DESC,
    average_salaries.avg_salary DESC
LIMIT 25;

/*-- Analysis:
- High-demand core skills: SQL and Python dominate with 2,000+ job postings 
each, making them essential for job security.

- Big data & cloud = top salaries: Specialized tools like BigQuery (€166K), 
Spark (€138K), and Databricks (€111K) deliver the highest pay despite lower demand.

- Balanced toolkit matters: Combining core analytics (SQL, Python) with 
visualization (Tableau, Power BI) and cloud/big data expertise offers the best
 career ROI in Germany.
*/
