-- Question #1
SELECT COUNT(*)
FROM data_analyst_jobs;
--1793 rows

--Question #2
SELECT *
FROM data_analyst_jobs
LIMIT 10;
--ExxonMobil

--Question #3
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN';
--21
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY';
--27

--Question #4
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN'
AND star_rating > 4;
--3

--Question #5
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;
--151

--Question #6
SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY state
ORDER BY AVG(star_rating) DESC;
--NE, 4.1999998...
-- Below just removes the states with a null avg star rating and rounds the values to 2 places
SELECT location AS state, ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
GROUP BY state
HAVING AVG(star_rating) IS NOT NULL
ORDER BY AVG(star_rating) DESC;
--Keeping NULLS in but moving them to the end
SELECT location AS state, ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
GROUP BY state
ORDER BY AVG(star_rating) DESC NULLS LAST;
-- adding NULLS LAST does this

--Question #7
SELECT DISTINCT title
FROM data_analyst_jobs;

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;
--881

--Question #8
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';
--230

--Question #9
SELECT company, ROUND(AVG(star_rating), 3) AS overall_rating
FROM data_analyst_jobs
GROUP BY company
HAVING SUM(review_count) > 5000;

SELECT COUNT(company)
FROM(SELECT company
	FROM data_analyst_jobs
	GROUP BY company
	HAVING SUM(review_count) > 5000) AS high_reviews;
--70
--Below takes into account the fact that data was pre-aggregated, so no need to sum reviews
SELECT company, AVG(star_rating) AS overall_rating
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company;

SELECT COUNT(DISTINCT company)
FROM data_analyst_jobs
WHERE review_count > 5000;
-40

--Question #10
SELECT company, AVG(star_rating) AS overall_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL
GROUP BY company
HAVING SUM(review_count) > 5000
ORDER BY overall_rating DESC;
--Google 4.3...
--Below takes into account the fact that data was pre-aggregated, so no need to sum reviews
SELECT company, AVG(star_rating) AS overall_rating, AVG(review_count) AS rvw_count
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY overall_rating DESC;
--General Motors, Unilever, Microsoft, Nike, American Express, Kaiser Permanente all tied at 4.1999998....
--Below takes into account that ratings are already averaged across all locations, SO, really pretty simple
SELECT DISTINCT company, star_rating, review_count
FROM data_analyst_jobs
WHERE review_count > 5000
ORDER BY star_rating DESC;


--Question #11
SELECT title
FROM data_analyst_jobs
WHERE title LIKE '%Analyst%';

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title LIKE '%Analyst%';
--754
--Code below uses case insensitive keyword ILIKE
SELECT title
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';
--774

--Question #12
SELECT title
FROM data_analyst_jobs
WHERE title NOT LIKE '%Analyst%'
AND title NOT LIKE '%Analytics%';

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title NOT LIKE '%Analyst%'
AND title NOT LIKE '%Analytics%';
--26, most have analytics or analyst w/ different capitalizations
--Code below uses case insensitive keyword ILIKE
SELECT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%'
AND title NOT ILIKE '%Analytics%';

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%'
AND title NOT ILIKE '%Analytics%';
--4, Tableau

--Bonus
SELECT domain, COUNT(*) AS hard_to_fill, AVG(days_since_posting) AS avg_days_posted, 
		MIN(days_since_posting) AS min_days, MAX(days_since_posting) AS max_days
FROM data_analyst_jobs
WHERE days_since_posting > 21
AND skill ILIKE '%sql%'
AND domain IS NOT NULL
GROUP BY domain
ORDER BY hard_to_fill DESC
LIMIT 4;
/* Internet and Software- 62 jobs
Banks and Financial Services- 61 jobs
Consulting and Business Services- 57
Health Care- 52 jobs*/