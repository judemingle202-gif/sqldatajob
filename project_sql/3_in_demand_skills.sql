/*
Question: What are the most in-demand skills for data analysts in Germany?
- join job postings to inner join table similar to previous query
- identify the top 5 skills that are most frequently mentioned in job postings
- WHY? Provide insights into the skills that are most sought after in the job market for data
 analysts in Germany. 
*/

SELECT 
    skills,
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
    skills
ORDER BY 
    demand_count DESC
LIMIT 5;

/*-- Analysis:
. Core Technical Skills (The Must-Haves)
- SQL is King: SQL is the single most in-demand skill, making proficiency in advanced querying
non-negotiable.

- Python is Essential: Python is the second-most requested skill, cementing its role as
 the primary programming language for data manipulation and analysis.

-Visualization is Key: Both Tableau and Power BI are in the top five, emphasizing the need to 
create compelling, professional data visualizations.

-Excel Matters: Excel still ranks highly, indicating that strong spreadsheet and data handling
 skills are required for day-to-day tasks.

[
  {
    "skills": "sql",
    "demand_count": "2798"
  },
  {
    "skills": "python",
    "demand_count": "2203"
  },
  {
    "skills": "tableau",
    "demand_count": "1300"
  },
  {
    "skills": "excel",
    "demand_count": "1281"
  },
  {
    "skills": "power bi",
    "demand_count": "1261"
  }
]

 */