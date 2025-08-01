-- 1. How many rows are in the data_analyst_jobs table?
SELECT COUNT(*)
FROM data_analyst_jobs;


-- 2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM 
	data_analyst_jobs
ORDER BY 
	company
LIMIT 1 OFFSET 9;

-- 3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT 
	COUNT(location) AS TN_count
FROM 
	data_analyst_jobs
WHERE 
	location LIKE 'TN%';

-- 4. How many postings in Tennessee have a star rating above 4?
SELECT 
	COUNT(location) AS TN_star_count
FROM 
	data_analyst_jobs
WHERE 
	location LIKE 'TN%'
	AND star_rating > 4;


-- 5. How many postings in the dataset have a review count between 500 and 1000?

SELECT 
	COUNT(review_count) AS high_review
FROM 
	data_analyst_jobs
WHERE review_count >= 500 AND review_count <= 1000;


-- 6. Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?
SELECT
 	location AS state_location, ROUND(AVG(star_rating)) AS avg_rating
FROM
	data_analyst_jobs
GROUP BY
	state_location
ORDER BY AVG(star_rating) DESC;

-- 7. Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT
 	DISTINCT title
FROM
	data_analyst_jobs;

-- 8. How many unique job titles are there for California companies?
SELECT
 	COUNT(DISTINCT company)
FROM
	data_analyst_jobs
WHERE company LIKE '%California%';

-- 9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
SELECT 
	company, 
	AVG(star_rating) AS avg_star_rating,
	SUM(review_count) AS total_reviews
FROM 
	data_analyst_jobs
GROUP BY 
	company
HAVING SUM(review_count) > 5000
ORDER BY total_reviews DESC;


--10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT 
	company, 
	AVG(star_rating) AS avg_star_rating,
	SUM(review_count) AS total_reviews
FROM 
	data_analyst_jobs
GROUP BY 
	company
HAVING SUM(review_count) > 5000
ORDER BY avg_star_rating DESC;

--11. Find all the job titles that contain the word ‘Analyst’. 

SELECT
	title
FROM
	data_analyst_jobs
WHERE title LIKE '%Analyst%'
GROUP BY title;

-- How many different job titles are there?

SELECT
	COUNT(DISTINCT title) AS title_count
FROM
	data_analyst_jobs
WHERE title LIKE '%Analyst%';

--12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT
 	COUNT(title) AS title_count
FROM
	data_analyst_jobs
WHERE title NOT LIKE '%Analyst%' AND title NOT LIKE '%Analytics%';

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.

-- Disregard any postings where the domain is NULL.
-- Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
-- Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

SELECT domain, COUNT(*) AS job_count
FROM 
	data_analyst_jobs
WHERE 
	skill LIKE '%SQL%' 
AND days_since_posting > 21
AND domain IS NOT NULL
GROUP BY 
	domain
ORDER BY 
	job_count DESC
LIMIT 4;

