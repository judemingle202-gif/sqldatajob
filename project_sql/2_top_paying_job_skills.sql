/*
Question: What skills are required for the top-paying data analyst jobs in Germany?
- Use the top 10 highest-paying Data Analyst roles identified in the previous query.
- Add the specific skills required for these roles by joining with the job_skills_dim table.
- WHY? Provide insights into the skills that can help secure high-paying data analyst positions with
top salaries.
*/


WITH top_paying_jobs AS
(
    SELECT 
        job_id,
        job_title,
        job_location,
        salary_year_avg,
        company_dim.name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id    
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location LIKE '%Germany%' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10    
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skill_id,
    skills_dim.skills AS skill_required
FROM
    top_paying_jobs
INNER JOIN 
  skills_job_dim ON skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN 
  skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY 
  top_paying_jobs.salary_year_avg DESC;

/*-- Analysis:
- Research roles (Bosch) lead the salary charts (~€200K), with strong demand for
 Spark and GitHub skills.

- Leadership positions (Head of Data Analytics) require a broad mix of skills
 — Python, SQL, Cloud platforms (GCP, Redshift, BigQuery), and BI tools 
 (Tableau, Looker, Power BI).

- Analyst & Architect roles emphasize foundational skills (SQL, Python, R) 
combined with data visualization and business tools (Excel, Tableau, Pandas)
 to remain competitive.
 [
  {
    "job_id": 1202839,
    "job_title": "Technology Research Engineer for Power Semiconductors (f/m/div.)",
    "job_location": "Renningen, Germany",
    "salary_year_avg": "200000.0",
    "company_name": "Bosch Group",
    "skill_id": 92,
    "skill_required": "spark"
  },
  {
    "job_id": 1202839,
    "job_title": "Technology Research Engineer for Power Semiconductors (f/m/div.)",
    "job_location": "Renningen, Germany",
    "salary_year_avg": "200000.0",
    "company_name": "Bosch Group",
    "skill_id": 216,
    "skill_required": "github"
  },
  {
    "job_id": 107183,
    "job_title": "Research Engineer (f/m/div.)",
    "job_location": "Hildesheim, Germany",
    "salary_year_avg": "200000.0",
    "company_name": "Bosch Group",
    "skill_id": 92,
    "skill_required": "spark"
  },
  {
    "job_id": 156108,
    "job_title": "Research Engineer for Security and Privacy  (f/m/div.)",
    "job_location": "Renningen, Germany",
    "salary_year_avg": "199675.0",
    "company_name": "Bosch Group",
    "skill_id": 92,
    "skill_required": "spark"
  },
  {
    "job_id": 156108,
    "job_title": "Research Engineer for Security and Privacy  (f/m/div.)",
    "job_location": "Renningen, Germany",
    "salary_year_avg": "199675.0",
    "company_name": "Bosch Group",
    "skill_id": 216,
    "skill_required": "github"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "job_location": "Berlin, Germany",
    "salary_year_avg": "166419.5",
    "company_name": "Volt.io",
    "skill_id": 0,
    "skill_required": "sql"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "job_location": "Berlin, Germany",
    "salary_year_avg": "166419.5",
    "company_name": "Volt.io",
    "skill_id": 1,
    "skill_required": "python"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "job_location": "Berlin, Germany",
    "salary_year_avg": "166419.5",
    "company_name": "Volt.io",
    "skill_id": 182,
    "skill_required": "tableau"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "job_location": "Berlin, Germany",
    "salary_year_avg": "166419.5",
    "company_name": "Volt.io",
    "skill_id": 183,
    "skill_required": "power bi"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "job_location": "Munich, Germany",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skill_id": 1,
    "skill_required": "python"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "job_location": "Munich, Germany",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skill_id": 2,
    "skill_required": "nosql"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "job_location": "Munich, Germany",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skill_id": 77,
    "skill_required": "bigquery"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "job_location": "Munich, Germany",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skill_id": 78,
    "skill_required": "redshift"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "job_location": "Munich, Germany",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skill_id": 81,
    "skill_required": "gcp"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "job_location": "Munich, Germany",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skill_id": 98,
    "skill_required": "kafka"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "job_location": "Munich, Germany",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skill_id": 182,
    "skill_required": "tableau"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "job_location": "Munich, Germany",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skill_id": 185,
    "skill_required": "looker"
  },
  {
    "job_id": 20461,
    "job_title": "Head of Data Analytics (F/M/X)",
    "job_location": "Munich, Germany",
    "salary_year_avg": "166419.5",
    "company_name": "PPRO",
    "skill_id": 212,
    "skill_required": "terraform"
  },
  {
    "job_id": 931367,
    "job_title": "Data Architect (m/w/d)",
    "job_location": "Hamburg, Germany",
    "salary_year_avg": "165000.0",
    "company_name": "Datalogue GmbH",
    "skill_id": 0,
    "skill_required": "sql"
  },
  {
    "job_id": 931367,
    "job_title": "Data Architect (m/w/d)",
    "job_location": "Hamburg, Germany",
    "salary_year_avg": "165000.0",
    "company_name": "Datalogue GmbH",
    "skill_id": 1,
    "skill_required": "python"
  },
  {
    "job_id": 931367,
    "job_title": "Data Architect (m/w/d)",
    "job_location": "Hamburg, Germany",
    "salary_year_avg": "165000.0",
    "company_name": "Datalogue GmbH",
    "skill_id": 81,
    "skill_required": "gcp"
  },
  {
    "job_id": 537995,
    "job_title": "Data Analyst/Manager - Last Mile Planning (m/f/d)",
    "job_location": "Berlin, Germany",
    "salary_year_avg": "111202.0",
    "company_name": "Flink",
    "skill_id": 1,
    "skill_required": "python"
  },
  {
    "job_id": 537995,
    "job_title": "Data Analyst/Manager - Last Mile Planning (m/f/d)",
    "job_location": "Berlin, Germany",
    "salary_year_avg": "111202.0",
    "company_name": "Flink",
    "skill_id": 5,
    "skill_required": "r"
  },
  {
    "job_id": 155801,
    "job_title": "Financial Data Analyst & Consultant (m/f/d)",
    "job_location": "Düsseldorf, Germany",
    "salary_year_avg": "111175.0",
    "company_name": "Experian",
    "skill_id": 0,
    "skill_required": "sql"
  },
  {
    "job_id": 155801,
    "job_title": "Financial Data Analyst & Consultant (m/f/d)",
    "job_location": "Düsseldorf, Germany",
    "salary_year_avg": "111175.0",
    "company_name": "Experian",
    "skill_id": 1,
    "skill_required": "python"
  },
  {
    "job_id": 774732,
    "job_title": "(Senior) People Data Analyst (m/w/x)",
    "job_location": "Germany",
    "salary_year_avg": "111175.0",
    "company_name": "Grover",
    "skill_id": 181,
    "skill_required": "excel"
  },
  {
    "job_id": 774732,
    "job_title": "(Senior) People Data Analyst (m/w/x)",
    "job_location": "Germany",
    "salary_year_avg": "111175.0",
    "company_name": "Grover",
    "skill_id": 183,
    "skill_required": "power bi"
  }
]
 */

 