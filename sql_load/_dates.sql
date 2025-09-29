SELECT '2023-02-19' ::DATE,
       '123'::INTEGER,
       'true'::BOOLEAN,
       '3.14'::REAL;

SELECT 
     job_title_short AS title,
     job_location AS location,
     job_posted_date::DATE AS date 
FROM
     job_postings_fact;   
     
SELECT 
     job_title_short AS title,
     job_location AS location,
     job_posted_date AS date_time
FROM
     job_postings_fact LIMIT 5; 

SELECT 
     job_title_short AS title,
     job_location AS location,
     job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST',
     EXTRACT(MONTH FROM job_posted_date) AS date_month,
     EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM
     job_postings_fact LIMIT 5;

-- number of data analyst jobs  posted every month
SELECT 
    COUNT(job_id) AS no_of_analyst_jobs,
    EXTRACT(MONTH FROM job_posted_date) as month 
FROM 
    job_postings_fact
WHERE        
    job_title_short = 'Data Analyst'    
GROUP BY
     month 
ORDER BY no_of_analyst_jobs DESC;      
        
-- average salary yearly and hourly posted after june 1 2023 by job schedule
SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS avg_yearly_salary,
    AVG(salary_hour_avg) AS avg_hourly_salary
FROM
    job_postings_fact
 WHERE
    job_posted_date > '2023-06-01'
  GROUP BY
    job_schedule_type;

-- no of job postings for each month in 2023,adjusting date in AmericaNewYork time zone
-- group and order by month
SELECT
    COUNT(job_id) AS no_of_postings,
    EXTRACT(MONTH FROM job_posted_date) AS month_posted 
 FROM
    job_postings_fact
GROUP BY
   month_posted
ORDER BY
    month_posted;  

--companies that have posted jobs offering health insurance in the second quarter of 2023

SELECT
    DISTINCT(company_dim.name),
    job_postings_fact.job_health_insurance,
    EXTRACT(MONTH FROM job_postings_fact.job_posted_date) AS months
FROM
    company_dim
LEFT JOIN job_postings_fact ON company_dim.company_id = job_postings_fact.company_id 
WHERE 
     EXTRACT(QUARTER  FROM job_postings_fact.job_posted_date) = 2 AND
    EXTRACT(YEAR  FROM job_postings_fact.job_posted_date) = 2023 AND
    job_health_insurance = TRUE
    ORDER BY months;  



                           