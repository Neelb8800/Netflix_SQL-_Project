DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
      show_id VARCHAR(6),
	  type    VARCHAR(10),
	  title   VARCHAR(150),
	  director VARCHAR(208),
	  casts     VARCHAR(10000),
	  country  VARCHAR(150),
	  date_added VARCHAR(50),
	  release_year VARCHAR(10),
	  rating     VARCHAR(10),
	  duration   VARCHAR(15),
	  listed_in  VARCHAR(100),
	  description VARCHAR(250)	  
);


SELECT * FROM netflix;

SELECT COUNT(*) AS total_content FROM netflix

SELECT DISTINCT TYPE FROM netflix

-- 15 Business Problem --

1.Count the number of movies vs TV shows.
SELECT type,COUNT(*) as total_content from netflix
Group by type

2. Find the most common rating for movies and TV shows.

SELECT type,rating, COUNT(*) AS count
FROM netflix
GROUP BY type, rating
ORDER BY type,count DESC;

3. List all movies in a specific year (e.g. 2020).
SELECT * FROM netflix
WHERE
    type = 'Movie'
	AND 
	release_year = '2020'

4. Find the top 5 countries with the most content on Netflix.
select * from netflix
SELECT 
      UNNEST(STRING_TO_ARRAY(country,',')) as new_country,
	  COUNT(show_id) As total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

5. Identify the longest movie.
SELECT * FROM netflix
WHERE 
     type = 'Movie'
	 AND
	 duration = (SELECT MAX(duration) from netflix)

6. Find the content added in the last 5 years.

SELECT * FROM netflix
WHERE 
     	 TO_DATE(date_added,'Month DD, YYYY') >= CURRENT_DATE - INTERVAL'5 YEARS'

7. Find all the movies/TV shows by director 'Rajiv Chilaka'.

SELECT * FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%'

8. List all TV shows with more than 5 seasons.

SELECT 
    * 
FROM netflix
WHERE  
    type ILIKE 'TV Show' 
    AND 
    SPLIT_PART(duration, ' ', 1)::numeric > 5;
	
9. Count the number of content items in each genre.
SELECT 
     UNNEST(STRING_TO_ARRAY(listed_in,',')) AS genre,
	 COUNT(show_id) as total_content  
FROM netflix
GROUP BY 1

10. Find each year and the average numbers of content release by India on Netflix.
Return top 5 year with highest avg content release.

SELECT  
    EXTRACT (Year from TO_DATE(date_added,'Month DD,YYYY')) AS year,
      COUNT(*) as yearly_content,
	  ROUND(
	  COUNT(*)::numeric/(SELECT COUNT(*) FROM netflix WHERE country = 'India')::numeric * 100
	  ,2)as avg_content_per_year
FROM netflix
WHERE country = 'India'
GROUP BY 1

11. List all movies that are documentaries.

SELECT * FROM netflix
WHERE
    listed_in ILIKE '%documentaries%'

12. Find all content without a director.
SELECT * FROM netflix
WHERE
     director IS NULL

13.Find how many movies actor 'Salman Khan' appeared in last 10 years.

SELECT * 
FROM netflix
WHERE 
    casts ILIKE '%Salman Khan%'
    AND 
    CAST(release_year AS INTEGER) > EXTRACT(YEAR FROM CURRENT_DATE) - 10;

14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
SELECT 
--show_id,
--casts,
UNNEST(STRING_TO_ARRAY(Casts,',')) as actors,
COUNT(*) AS total_content
FROM netflix
WHERE country LIKE '%India'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10








