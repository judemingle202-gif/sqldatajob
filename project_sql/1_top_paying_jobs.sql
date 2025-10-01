/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available in Germany.
- Focuses on job postings with specified salaries (remove nulls).
- WHY? Highlight the top paying opportunities for data analysts, offering insights into employment
*/

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::DATE,
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
LIMIT 10;

/*--Analysis:
Bosch Group dominates the top tier, with Research Engineer roles offering salaries
 near €200,000, the highest in the dataset.

Leadership roles like Head of Data Analytics (Volt.io, PPRO) and specialized positions like 
Data Architect also rank high, averaging €165,000–166,000.

Standard Data Analyst roles (Flink, Experian, Bosch eBike Systems) average around €111,000, 
showing a clear gap compared to research and leadership positions.
*/