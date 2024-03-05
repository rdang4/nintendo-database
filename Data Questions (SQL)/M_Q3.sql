/*************************************************************************

Question 3 from Methodology (SQL)

NINTENDO SWITCH LIBRARY AND DATA ANALYTICS 

**************************************************************************
Q3: More Specific Questions
**************************************************************************/


/********* NOTE: ***********

I will need to use the **```joined_dataset```** table again to be able to generate the total amount of sales, 
denoted as **```total_sales```**, for each ESRB rating. 
To achieve the total amount in sales, we can use the **```SUM```** function to gather my results.

****************************/

-- Q3.1: Sum Total Sales For Each ESRB Rating --

-- Create esrb_total_sales_mil table using the joined_dataset
DROP TABLE IF EXISTS esrb_total_sales_mil;

-- SUM is used to calculate the total sales for each ESRB in the total_sales column
CREATE TEMP TABLE esrb_total_sales_mil AS
SELECT esrb, 
       SUM(sales_mil) AS total_sales
FROM joined_dataset
GROUP BY esrb;

SELECT * FROM esrb_total_sales_mil
ORDER BY total_sales DESC;

-- Result:
+─────────+─────────────────+
| esrb    | total_sales     |
+─────────+─────────────────+
| RP      | [null]          |
| E       | 328.330         |
| E10+    | 184.400         |
| T       | 36.560      	  |
| M       | 13.520          |
+─────────+─────────────────+

--------------------------------------------------------------------------------------
  
-- Q3.2: Game Count In Top Genre --

-- Create top_genre_game_count table from genre_count_and_avg table in Q2
DROP TABLE IF EXISTS top_genre_game_count;

CREATE TEMP TABLE top_genre_game_count AS

SELECT genre_id,
       genre_name,
       game_count
FROM genre_count_and_avg
WHERE genre_name = 'Open-World'
GROUP BY genre_name, genre_id, game_count;

SELECT * FROM top_genre_game_count;

-- Result:
+──────────+─────────────────────+────────────+
| genre_id | genre_name          | game_count |
+──────────+─────────────────────+────────────+
| 19       | Open-World          | 6	        |
+──────────+─────────────────────+────────────+

--------------------------------------------------------------------------------------
  
-- Q3.3: Difference Between Genre Count --

-- ** Our top 3 genres were; Open-World, Action RPG, and Action Adventure. ** 

-- Create difference_top_genre with column named difference
DROP TABLE IF EXISTS difference_top_genres;

CREATE TEMP TABLE difference_top_genres AS

-- To subtract two values together, they must be selected individually.
SELECT 
	 (SELECT game_count
	  FROM genre_count_and_avg
	  WHERE genre_name = 'Open-World') -
	 (SELECT game_count
	  FROM genre_count_and_avg
	  WHERE genre_name = 'Action Adventure')
AS difference;

SELECT * FROM difference_top_genres;

-- Result:
+────────────+
| difference |
+────────────+
| 1          |
+────────────+

/**************************************************

FINISHING THOUGHTS FOR Q3.3:

Open-World has 6 games and Action Adventure has 5 games in my database. 
This means that the difference displayed in our result is correct!  

***************************************************/

--------------------------------------------------------------------------------------
  
-- Q3.4: Percentage of Genres --
  -- For Part 1, we need to gather the total count of games released by Nintendo.

-- Create total_nintendo_games table to find how many games are in the dataset  
DROP TABLE IF EXISTS total_nintendo_games;

CREATE TEMP TABLE total_nintendo_games AS

-- total_games as our count 
SELECT COUNT(*) AS total_games 
FROM joined_dataset
WHERE publisher_name = 'Nintendo';

SELECT * FROM total_nintendo_games;

-- Result:
+─────────────+
| total_games |
+─────────────+
| 71          |
+─────────────+

-- For Part 2, we find the percentatge of Open-World games released by Nintendo.
  -- Our top genre will be Open-World with a total of 6 out of 71 games.

DROP TABLE IF EXISTS percent_ow_joint_table;

CREATE TEMP TABLE percent_ow_joint_table AS

-- Create a CAST around the individually selected values to be able to shorten the decimals
-- Change bigint values to float in order to gather approximate decimal values 
SELECT
	 CAST((SELECT MIN(game_count)::float 
	  FROM top_genre_game_count) /

	 (SELECT total_games::float
	  FROM total_nintendo_games) * 100 AS numeric(10,2))
AS percentage_open_world;

SELECT * FROM percent_ow_joint_table;

-- Result:
+───────────────────────+
| percentage_open_world |
+───────────────────────+
| 8.45                  |
+───────────────────────+

/***************************************************

FINISHING THOUGHTS FOR Q3.4, PART 2:

I was able to easily divide both numbers to get our percentage of Open-World games. 
I needed to convert numbers from **```game_count```** and **```total_games```** 
to **```float```** in order to get the approximate numerical values. 
Afterwards, I was able to round the decimals to 2 places using the **```CAST```** and **```numeric```** functions.

***************************************************/

-- For Part 3, lets find the percentages of all genres relative to the total games released by Nintendo.

DROP TABLE IF EXISTS percent_genre_joint_table;

CREATE TEMP TABLE percent_genre_joint_table AS

-- To be able to output all percentages, we need game_count from genre_count_and_avg
SELECT genre_id,
       genre_name,
       CAST(game_count::float /
       (SELECT total_games::float
       FROM total_nintendo_games) * 100 AS numeric(10,2)) AS percentage_genres 
FROM genre_count_and_avg;

SELECT * FROM percent_genre_joint_table
ORDER BY percentage_genres DESC;

-- Result:
+──────────+──────────────────────+───────────────────+
| genre_id | genre_name           | percentage_genres |
+──────────+──────────────────────+───────────────────+
| 22       | Platformer           | 14.08             |
| 24       | RPG                  | 9.86              |
| 19       | Open-World           | 8.45              |
| 2        | Action Adventure     | 7.04              |
| 41       | JRPG                 | 7.04              |
| 4        | Action RPG           | 7.04              |
| 20       | Party/Minigame       | 4.23              |
| 31       | Simulation           | 4.23              |
| 25       | Racing               | 4.23              |
| 3        | Action Puzzle        | 4.23              |
| 36       | Third-Person Shooter | 4.23              |
| 23       | Puzzle               | 4.23              |
| 14       | Fighting             | 4.23              |
| 38       | Turn-Based Strategy  | 2.82              |
| 11       | Compilation          | 2.82              |
| 26       | Real-Time Strategy   | 2.82              |
| 27       | Rhythm               | 1.41              |
| 15       | First-Person Shooter | 1.41              |
| 13       | Exercise/Fitness     | 1.41              |
| 35       | Tactics              | 1.41              |
| 8        | Beat-''Em-Up         | 1.41              |
| 1        | Action               | 1.41              |
+──────────+──────────────────────+───────────────────+

/***************************************************

FINISHING THOUGHTS FOR Q3.4, PART 3:

We can see the result for all genres all in one table above.
As expected, the Open-World genre has the same percentage as the result before.
Now we know that in our database, Platformers make up 14.08% of the total games by Nintendo.
The smallest percentage of all genres are Rhythm, First-Person Shooter, 
Exercise/Fitness, Tactics, Beat-'Em-Up, and Action games.

***************************************************/
  
