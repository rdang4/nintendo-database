/****************************************************************

This will be Question 1 from Methodology (SQL)

NINTENDO SWITCH LIBRARY AND DATA ANALYTICS 

*****************************************************************
Q1: What are the top 3 genres of all games published by Nintendo?
(Find the count and average scores of games for each genre)
*****************************************************************/

/* *** IMPORTANT ***:

To be able to execute all the tables for each question, we need to begin with the "joined_dataset" table
we created in the previous step. 

If this is the file that you are looking at from the start, it will get a little confusing! Again, if we need
things to work, the query below is needed to prevent mistakes:

(You can find this query under the Data Join folder of this project)

--- Beginning of the Query ---

DROP TABLE IF EXISTS joined_dataset;

CREATE TEMP TABLE joined_dataset AS
SELECT game.game_id,
       game.title,
       genre.genre_id,
       genre.name AS genre_name,
       game.esrb,
       game.metascore,
       game.user_score,
       publisher.name AS publisher_name, 
       developer.name AS developer_name
FROM game

INNER JOIN game_category
	ON game.game_id = game_category.game_id
INNER JOIN genre
	ON game_category.genre_id = genre.genre_id
INNER JOIN game_developer
	ON game.game_id = game_developer.game_id
INNER JOIN developer
	ON game_developer.developer_id = developer.developer_id
INNER JOIN game_publisher
	ON game.game_id = game_publisher.game_id
INNER JOIN publisher
	ON game_publisher.publisher_id = publisher.publisher_id;
	
SELECT * FROM joined_dataset
WHERE metascore IS NOT NULL
ORDER BY metascore DESC
LIMIT 10;  

--- End of the Query ---

*********************/

-- Create the genre_count_and_avg of all genres that were published by Nintendo specifically
DROP TABLE IF EXISTS genre_count_and_avg;

CREATE TEMP TABLE genre_count_and_avg AS

SELECT genre_id,
       genre_name, 
       ROUND(AVG(metascore),2) AS avg_score,
       COUNT(title) AS game_count
FROM joined_dataset
WHERE publisher_name = 'Nintendo'
GROUP BY publisher_name, genre_name, genre_id;

-- Output the highest average score with more than 3 games in descending order to avoid avg_score of 1-3 games only.
SELECT * FROM genre_count_and_avg
WHERE game_count > 3
ORDER BY avg_score DESC;

-- Result: 
+──────────+─────────────────────+────────────+────────────+
| genre_id | genre_name          | avg_score  | game_count |
+──────────+─────────────────────+────────────+────────────+
| 19       | Open-World	         | 86.67      | 6          |
| 4        | Action RPG          | 86.60      | 5          |
| 2        | Action Adventure    | 86.40      | 5          |
| 22       | Platformer	         | 86.30      | 10         |
| 41       | JRPG                | 84.00      | 5          |
| 24       | RPG                 | 80.29      | 7          |
+──────────+─────────────────────+────────────+────────────+

-- We can say now that the top 3 genres published by Nintendo would be Open-World, Action RPG, and Action adventure games based on their average score on the Metacritic website.
