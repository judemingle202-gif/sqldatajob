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
.- SQL dominates the market, making it the most critical skill for Data Analysts in Germany.

- Python is highly sought after, reflecting the strong demand for programming and advanced 
analytics capabilities.

- Visualization & reporting tools (Tableau, Excel, Power BI) are nearly equal in demand,
 showing how important it is for analysts to communicate insights effectively..

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