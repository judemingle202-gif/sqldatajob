# 👋 Introduction
This project analyzes the German data job market to uncover the roles and skills that matter most. 💼
I explored top paying jobs 💰, top paying skills 🛠, and in-demand skills 📈 to see what employers value.
The analysis also ranks skill-based salaries 💵 and highlights the optimal skills 🎯 that balance demand with high pay.
These insights provide a clear picture of where opportunities lie for data professionals. 🚀
As an aspiring data analyst in Germany, this serves as both a guide and a roadmap for my career path. 🌟
📂 You can explore the full analysis and code in this folder 👉 [project_sql folder](/project_sql/)

# 🏗 Background
The motivation for this project came from my goal of understanding the German data job market as I prepare for a career as a data analyst. To guide the analysis, I focused on answering key questions:
	•	💼 What are the top paying jobs in Germany’s data field?
	•	🛠 Which skills pay the most and are most valuable to employers?
	•	📈 What are the most in-demand skills across job postings?
	•	💵 How do individual skills rank by salary potential?
	•	🎯 Which optimal skills combine high demand with high salary?

This project was inspired by practice problems and analysis techniques from Luke Barousse’s YouTube channel, which provided a strong foundation for framing the questions and structuring the SQL analysis. You can check out his content here: [SQL Course](https://youtu.be/7mz73uXD9DA?si=MjlvkhgqwHjL0M_o)
# 🛠 Tools Used
To carry out this analysis, I worked with a range of tools that supported data exploration, query execution, and project management:

	•	🗄 SQL – for querying and analyzing job posting data

	•	🐘 PostgreSQL – as the database system to store and manage the dataset

	•	💻 Visual Studio Code – for writing, testing, and organizing SQL scripts

	•	🌿 Git – for version control and tracking project progress

	•	🐙 GitHub – for hosting and sharing the project repository

# 📊 The Analysis
To understand the dynamics of the data job market in Germany, I conducted a structured analysis focusing on both quantitative and qualitative aspects. The goal was to identify top paying jobs,top paying job skills,skills in high demand, top skill based on salary and  the most optimal skill. Below is how I uncovered patterns in job postings focusing in Germany by exploring different categories :

### 1. Top Paying Data Analyst Jobs
**Question**: What are the top-paying data analyst jobs in Germany?

**How?** By filtering out postings without salary data, the analysis identifies the top 10 highest-paying data-related roles in Germany.

**Why?** This analysis sheds light on the most lucrative opportunities for data professionals, helping candidates understand where advanced skills and leadership responsibilities translate into higher pay.

In order to find this results I entered the query below:

```sql
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
```

**Results:**

| Rank | Job Title                                                        | Company                 | Location         | Avg. Salary (€) |
| ---- | ---------------------------------------------------------------- | ----------------------- | ---------------- | --------------- |
| 1    | Research Engineer (f/m/div.)                                     | Bosch Group             | Hildesheim       | 200,000         |
| 2    | Technology Research Engineer for Power Semiconductors (f/m/div.) | Bosch Group             | Renningen        | 200,000         |
| 3    | Research Engineer for Security and Privacy (f/m/div.)            | Bosch Group             | Renningen        | 199,675         |
| 4    | Research Engineer / Scientist for Radar Development              | Fraunhofer-Gesellschaft | Germany (Remote) | 179,500         |
| 5    | Head of Data Analytics                                           | Volt.io                 | Berlin           | 166,419.5       |
| 6    | Head of Data Analytics (F/M/X)                                   | PPRO                    | Munich           | 166,419.5       |
| 7    | Data Architect (m/w/d)                                           | Datalogue GmbH          | Hamburg          | 165,000         |
| 8    | Data Analyst/Manager – Last Mile Planning (m/f/d)                | Flink                   | Berlin           | 111,202         |
| 9    | Financial Data Analyst & Consultant (m/f/d)                      | Experian                | Düsseldorf       | 111,175         |
| 10   | Data Analyst / Data Scientist – eBike Systems (w/m/div.)         | Bosch Group             | Kusterdingen     | 111,175         |

**Insights:**

- Bosch Group dominates the top tier, with Research Engineer roles offering salaries
 near €200,000, the highest in the dataset.

- Leadership roles like Head of Data Analytics (Volt.io, PPRO) and specialized positions like 
Data Architect also rank high, averaging €165,000–166,000.

- Standard Data Analyst roles (Flink, Experian, Bosch eBike Systems) average around €111,000, 
showing a clear gap compared to research and leadership positions.

### 2. Top Paying Job Based on Skills
**Question**: What skills are required for the top-paying data analyst jobs in Germany?

**How?** By joining the top 10 highest-paying jobs with the job_skills_dim table, the analysis reveals that the most lucrative positions that consistently demand specific skills.

**Why?** Provide insights into the skills that can help secure high-paying data analyst positions with
top salaries.

The query below helped answer the question asked :

```sql
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
```

**Results:**

| Rank | Job Title                                                               | Company         | Avg. Salary (€) | Key Skills Required                                                       |
| ---- | ----------------------------------------------------------------------- | --------------- | --------------- | ------------------------------------------------------------------------- |
| 1    | Technology Research Engineer for Power Semiconductors (f/m/div.)        | Bosch Group     | 200,000         | Spark, GitHub                                                             |
| 2    | Research Engineer (f/m/div.)                                            | Bosch Group     | 200,000         | Spark                                                                     |
| 3    | Research Engineer for Security and Privacy (f/m/div.)                   | Bosch Group     | 199,675         | Spark, GitHub                                                             |
| 4    | Head of Data Analytics (F/M/X)                                          | PPRO            | 166,419.5       | Python, NoSQL, BigQuery, Redshift, GCP, Kafka, Tableau, Looker, Terraform |
| 5    | Head of Data Analytics                                                  | Volt.io         | 166,419.5       | SQL, Python, Tableau, Power BI                                            |
| 6    | Data Architect (m/w/d)                                                  | Datalogue GmbH  | 165,000         | SQL, Python, GCP                                                          |
| 7    | Data Analyst/Manager - Last Mile Planning (m/f/d)                       | Flink           | 111,202         | Python, R                                                                 |
| 8    | Data Analyst                                                            | Barbaricum      | 111,175         | SQL, Python, R, Go, JavaScript, React, Flask                              |
| 9    | Publicis Media - Data Analyst im Bereich Data Science (m/w/d)           | Publicis Groupe | 111,175         | SQL, Python, Spark, Pandas, Excel, Tableau, PowerPoint                    |
| 10   | Financial Data Analyst & Consultant (m/f/d) *(not shown in skill join)* | Experian        | 111,175         | (Skills not listed in dataset extract)                                    |

**Insights:**

- Research roles (Bosch) lead the salary charts (~€200K), with strong demand for Spark and GitHub skills.

- Leadership positions (Head of Data Analytics) require a broad mix of skills — Python, SQL, Cloud platforms (GCP, Redshift, BigQuery), and BI tools (Tableau, Looker, Power BI).

- Analyst & Architect roles emphasize foundational skills (SQL, Python, R) combined with data visualization and business tools (Excel, Tableau, Pandas) to remain competitive.

### 3. Most In-Demand Skills
**Question:** What are the most in-demand skills for data analysts in Germany?

**How?** Identify the top 5 skills that are most frequently mentioned in job postings.

**Why?** Provide insights into the skills that are most sought after in the job market for data analysts in Germany.

The query below provides the answer to this task:

```sql
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
```
**Results:**

| Rank | Skill    | Demand Count |
| ---- | -------- | ------------ |
| 1    | SQL      | 2,798        |
| 2    | Python   | 2,203        |
| 3    | Tableau  | 1,300        |
| 4    | Excel    | 1,281        |
| 5    | Power BI | 1,261        |

**Insights:**

- SQL dominates the market, making it the most critical skill for Data Analysts in Germany.

- Python is highly sought after, reflecting the strong demand for programming and advanced analytics capabilities.

- Visualization & reporting tools (Tableau, Excel, Power BI) are nearly equal in demand, showing how important it is for analysts to communicate insights effectively.

### 4. Top Skill Based Salary

**Question:** What are the top skills based on salary?

**How?** Look at the average salary associated with each skill for Data Analyst positions. Focus on roles with specified salaries in Germany.

**Why?** To reveal how different skills impact salary levels for data analysts and helps identify the most 
financially rewarding skills to acquire or improve.

This query helps us arrive at the results:

```sql
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
```

**Results:**

| Rank | Skill         | Avg. Salary (€) |
| ---- | ------------- | --------------- |
| 1    | Kafka         | 166,419.50      |
| 2    | Terraform     | 166,419.50      |
| 3    | BigQuery      | 166,419.50      |
| 4    | NoSQL         | 166,419.50      |
| 5    | Redshift      | 166,419.50      |
| 6    | GitHub        | 150,896.33      |
| 7    | Spark         | 138,260.71      |
| 8    | GCP           | 127,477.83      |
| 9    | No-SQL        | 111,175.00      |
| 10   | Flask         | 111,175.00      |
| 11   | Terminal      | 111,175.00      |
| 12   | Databricks    | 111,175.00      |
| 13   | Elasticsearch | 111,175.00      |
| 14   | Matlab        | 111,175.00      |
| 15   | React         | 111,175.00      |
| 16   | PySpark       | 111,175.00      |
| 17   | JavaScript    | 111,175.00      |
| 18   | Pandas        | 108,412.50      |
| 19   | Matplotlib    | 107,491.67      |
| 20   | NumPy         | 105,650.00      |
| 21   | SAS           | 105,650.00      |
| 22   | Git           | 105,000.00      |
| 23   | Python        | 104,963.09      |
| 24   | Atlassian     | 102,500.00      |
| 25   | Power BI      | 97,748.63       |

**Insights:**

- Top-tier salaries (~€166K) are linked to cloud, database, and infrastructure tools (Kafka, BigQuery, NoSQL, Redshift, Terraform).

- Big data & distributed computing skills (Spark, Databricks, PySpark, GCP) form the second-highest salary group (€120K–€138K).

- Programming & analytics staples (Python, Pandas, NumPy, Git) and BI tools (Power BI) remain valuable, but average salaries are closer to €100K, showing less premium compared to cloud/data engineering skills.

### 5. Optimal Skill
**Question:** What are the most in-demand skills (i.e high demand and high salary) to learn?

**How**? 
- Identify skills in high demand and associated with high salaries for Data Analyst roles.
- Combine insights from previous queries on in-demand skills and top-paying skills.


**Why?** Targets skills that offer job security and financial reward, guiding skill
 development for aspiring data analysts in Germany.

 Query for this task:

 ```sql
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
 ```

**Results:**

| Rank | Skill      | Demand Count | Avg. Salary (€) |
| ---- | ---------- | ------------ | --------------- |
| 1    | SQL        | 2,798        | 93,761.65       |
| 2    | Python     | 2,203        | 104,963.09      |
| 3    | Tableau    | 1,300        | 97,645.42       |
| 4    | Excel      | 1,281        | 87,623.43       |
| 5    | Power BI   | 1,261        | 97,748.63       |
| 6    | R          | 1,098        | 81,861.93       |
| 7    | SAP        | 668          | 78,007.00       |
| 8    | Azure      | 413          | 83,763.00       |
| 9    | Looker     | 274          | 86,927.30       |
| 10   | PowerPoint | 249          | 83,937.50       |
| 11   | AWS        | 246          | 84,004.67       |
| 12   | Go         | 199          | 66,554.25       |
| 13   | Java       | 194          | 75,067.50       |
| 14   | Oracle     | 188          | 56,700.00       |
| 15   | SAS        | 186          | 105,650.00      |
| 16   | JavaScript | 172          | 111,175.00      |
| 17   | SQL Server | 149          | 89,100.00       |
| 18   | Databricks | 134          | 111,175.00      |
| 19   | Git        | 133          | 105,000.00      |
| 20   | BigQuery   | 116          | 166,419.50      |
| 21   | Pandas     | 111          | 108,412.50      |
| 22   | Spark      | 107          | 138,260.71      |
| 23   | Matlab     | 90           | 111,175.00      |
| 24   | C#         | 72           | 82,083.75       |
| 25   | SAS        | 186          | 105,650.00      |

**Insight:**

- High-demand core skills: SQL and Python dominate with 2,000+ job postings each, making them essential for job security.

- Big data & cloud = top salaries: Specialized tools like BigQuery (€166K), Spark (€138K), and Databricks (€111K) deliver the highest pay despite lower demand.

- Balanced toolkit matters: Combining core analytics (SQL, Python) with visualization (Tableau, Power BI) and cloud/big data expertise offers the best career ROI in Germany.


# 📚 What I learned
Working through this SQL project from Luke Barousse’s YouTube course
 gave me both technical and practical experience:

- 🛠 **SQL Skill Growth:** I built confidence moving from basic queries **(SELECT, WHERE, GROUP BY)** to more advanced techniques **(JOINs, CTEs, subqueries, and aggregations)**. This helped me structure my code to answer real-world data problems step by step.

- ❓ **Asking the Right Questions:** The project trained me to frame queries around business-relevant questions like “What are the top-paying jobs?” or “Which skills are most in-demand?” — an essential skill for turning raw data into insights.

- 🌍 **Industry Insights (Germany Focus):** By filtering the dataset for Germany, I gained valuable perspective on the data analyst job market, identifying which skills are both high-paying and high-demand. This is especially important to me as I aim to pursue a data analyst career in Germany in the future.

# 🏁 Conclusions

This project provided a comprehensive look at the data analyst job market in Germany and gave me the chance to apply SQL to real-world, career-relevant questions.

- 💰 Top-Paying Jobs: Revealed that specialized research and leadership roles dominate the high end of salaries, showing the value of both technical depth and leadership experience.

- 🔑 Top-Paying Skills: Highlighted how cloud platforms (BigQuery, Redshift, GCP) and big data tools (Spark, Kafka, Databricks) can significantly boost earning potential.

- 📈 Most In-Demand Skills: Demonstrated the consistent demand for SQL, Python, Tableau, Excel, and Power BI, proving that strong fundamentals are still the backbone of data analysis.

- ⚖️ Optimal Skills (Salary + Demand): Showed that blending high-demand tools (SQL, Python) with premium niche skills (Spark, BigQuery, GCP) creates the best path for career growth.

🔎 For me, this analysis was especially relevant because it not only strengthened my SQL querying skills but also gave me direct insights into the German data job market, where I aspire to build my career as a data analyst.

👉 For any aspiring data analyst, the key takeaway is clear:

- Master the fundamentals (SQL, Python, BI tools).

- Invest in cloud & big data technologies.

- Stay curious and keep asking the right questions.

This blend of skills and curiosity will open doors to opportunities in the growing field of data analytics.