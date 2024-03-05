# Nintendo Switch Library and Data Analytics: Data Questions (SQL)

## Table of Contents

* [Approach to the Problems](#approach-to-the-problems)
   * [Question 1: Top 3 Genres by Nintendo](#q1-top-3-genres-by-nintendo)
   * [Question 2: Best Games From Those Top 3 Genres](#q2-best-games-in-top-3-genres)
   * [Question 3: More Specific Questions](#q3-more-specific-questions)
 * [All in All](#all-in-all)


---
## Approach to the Problems
With the combined data readily available, we can now leverage the unified table to answer any questions I might have. This process involved meticulously analyzing and connecting each table based on their underlying relationships.

## Q1: Top 3 Genres by Nintendo
### **#1: Joined Dataset**

The most important part of this question was to generate the **```genre_count```** of all genres and out of all of them, only **display games that were published by Nintendo**. With our **```joined_dataset```**, I am able to create another table that uses this dataset to output our **```genre_count```** that we are looking for.

```sql
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
```
### **#2: Genre Count and Average**
I will use the **```joined_dataset```** table to be able to create **```genre_count_and_avg```**.
```sql
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
```

✅ **Result:**
|genre_id|genre_name          |avg_score  |game_count|
|--------|--------------------|-----------|----------|
|19      |Open-World	      |86.67      |6	     |
|4       |Action RPG          |86.60      |5	     |
|2       |Action Adventure    |86.40      |5	     |
|22      |Platformer	      |86.30      |10	     |
|41      |JRPG	              |84.00      |5	     |
|24      |RPG 	              |80.29      |7	     |

---


## Q2: Best Games in Top 3 Genres
### **#1: Top Metascores (Part 1)**
I reused the same query as Question 1 but with a few tweaks to better represent this question. Using the **```joined_dataset```** we have created we will generate a new table for the top Metascores to find the best games. The key data columns are the **```title```** and **```metascore```** for the first part.

> We can use the **Metacritic ratings, user scores, or game sales** to find the most popular games. Since there is no accurate way of finding ALL game sales on the market, I will omit this from my findings. I decided to go with both ratings as the user scores represent the game audience while Metacritic scores is solely based on the opinions of the team associated with the website.
 
```sql
DROP TABLE IF EXISTS top_metascores;

CREATE TEMP TABLE top_metascores AS

SELECT game_id,
       title,
       metascore,
       genre_name
FROM joined_dataset
WHERE publisher_name = 'Nintendo';

-- Publishers filtered to Nintendo, next we filter the genre names that are in the top 3 from Q1 
SELECT * FROM top_metascores
WHERE genre_name IN ('Open-World', 'Action RPG', 'Action Adventure')
ORDER BY metascore DESC
LIMIT 10;  
```

✅ **Result Part 1:**
|game_id |title                              	 			 |metascore   |genre_name	  |
|--------|---------------------------------------------------------------|------------|-------------------|
|16      |The Legend of Zelda: Breath of the Wild  			 |97          |Open-World	  |
|59      |The Legend of Zelda: Tears of the Kingdom			 |96          |Open-World	  |
|73      |Xenoblade Chronicles 3: Expansion Pass Wave 4 - Future Redeemed|92          |Action RPG	  |
|71      |Bayonetta 2							 |92          |Action Adventure	  |
|96      |Xenoblade Chronicles: Definitive Edition			 |89          |Action RPG	  |
|98      |Xenoblade Chronicles 3					 |89          |Action RPG	  |
|142     |The Legend of Zelda: Link's Awakening 	                 |87          |Open-World	  |
|136     |Astral Chain                                                   |87          |Action Adventure	  |
|183     |Luigi's Mansion 3                                              |86          |Action Adventure	  |
|174     |Bayonetta 3							 |86          |Action Adventure	  |


### **#1: Top User Scores (Part 2)**
Now for part 2, I will gather the most popular games published by Nintendo within the top 3 genres listed above using the user scores. The process will be the same as Part 1, but we will create a table using **```user_score```** instead.
 
```sql
DROP TABLE IF EXISTS top_user_scores;

CREATE TEMP TABLE top_user_scores AS

SELECT game_id,
       title,
       user_score,
       genre_name
FROM joined_dataset
WHERE publisher_name = 'Nintendo';

-- Publishers filtered to Nintendo, next we filter the genre names that are in the top 3 from Q1 
SELECT * FROM top_user_scores
WHERE genre_name IN ('Open-World', 'Action RPG', 'Action Adventure')
ORDER BY user_score DESC
LIMIT 10;  
```

✅ **Result Part 2:**
|game_id |title                              	 			 |user_score  |genre_name	  |
|--------|---------------------------------------------------------------|------------|-------------------|
|71      |Bayonetta 2			  	 			 |8.9         |Action Adventure	  |
|73      |Xenoblade Chronicles 3: Expansion Pass Wave 4 - Future Redeemed|8.9         |Action RPG	  |
|136     |Astral Chain						 	 |8.9         |Action Adventure	  |
|96      |Xenoblade Chronicles: Definitive Edition			 |8.8         |Action RPG	  |
|16      |The Legend of Zelda: Breath of the Wild			 |8.7         |Open-World	  |
|904     |Bayonetta Origins: Cereza and the Lost Demon	  		 |8.5         |Action Adventure	  |
|98      |Xenoblade Chronicles 3				  	 |8.5         |Action RPG	  |
|326     |Xenoblade Chronicles 2					 |8.5         |Action RPG	  |
|961     |Xenoblade Chronicles 2: Torna ~ The Golden Country		 |8.5         |Action RPG	  |
|142     |The Legend of Zelda: Link's Awakening				 |8.4         |Action Adventure	  |

## Recommendations

### Based on Metascores for Category: **Open World**
*This would be my recommendation to you based on **Metascore** for **Nintendo games**:*
* ***The Legend of Zelda: Breath of the Wild***
* ***The Legend of Zelda: Tears of the Kingdom***
* ***The Legend of Zelda: Link's Awakening***

> It's so funny how the top 3 games recommended are from The Legend of Zelda series.

### Based on User Scores for Category: **RPG**
*This would be my recommendation to you based on **User Scores** for **Nintendo games**:*
* ***Pokemon Legends: Arceus***
* ***Paper Mario: The Origami King***
* ***Pokemon: Let's Go, Eevee!***

---


## Q3: More Specific Questions
### **#1 ESRB Rating and Sales**
With the amount of data I was able to gather for game sales on the Switch, will the ESRB rating have more sales? Once again, I will need to use the **```joined_dataset```** table to be able to generate the total amount of sales, denoted as **```total_sales```**, for each ESRB rating. To achieve the total amount in sales, we can use the **```SUM```** function to gather my results. Relatively simple.

```sql
DROP TABLE IF EXISTS esrb_total_sales_mil;

CREATE TEMP TABLE esrb_total_sales_mil AS
SELECT esrb, 
       SUM(sales_mil) AS total_sales
FROM joined_dataset
GROUP BY esrb;

SELECT * FROM esrb_total_sales_mil
ORDER BY total_sales DESC;
```

✅ **Result:**
|esrb    |total_sales     |
|--------|----------------|
|RP      |[null]          |
|E       |328.330         |
|E10+    |184.400         |
|T       |36.560 	  |
|M       |13.520          |

> The ESRB rating of **RP means Rating Pending**, therefore it would not have any sales data. 


### **#2: Nintendo Game Count In Top Genre**
This time I will use the **```genre_count_and_avg```** table to generate the **```genre_count```** for the top genre released by Nintendo. Since our **```genre_count_and_avg```** table already has filtered games to Nintendo, we do not have to specify it here again.

```sql
DROP TABLE IF EXISTS top_genre_game_count;

CREATE TEMP TABLE top_genre_game_count AS

SELECT genre_id,
       genre_name,
       game_count
FROM genre_count_and_avg
WHERE genre_name = 'Open-World'
GROUP BY genre_name, genre_id, game_count;

SELECT * FROM top_genre_game_count;
```

✅ **Result:**
|genre_id|genre_name          |game_count|
|--------|--------------------|----------|
|19      |Open-World	      |6	 |

### **#3: Difference Between Genre Counts**
This will involve basic arithmetic and since there will not be a significant amount of numbers. Our top 3 genres were; Open-World, Action RPG, and Action Adventure. I need to find how many more games were released in Open-World and Action Adventure. To be able to display our subtracted values, I need to create another table named **```difference_top_genre```** with a column named **```difference```**. I can subtract the count of Open-World with Action Adventure games by individually selecting and encasing them in parenthesis followed by "-" to subtract. 


```sql
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
```
✅ **Result:**
|difference |
|-----------|
|1	    |

> Open-World has 6 games and Action Adventure has 5 games in my database. This means that the difference displayed in our result is correct! It was A LOT harder figuring it out without creating another table for data joins specifically. In my [Methodology Folder Question 3.3](/Methodology%20(SQL)/README.md#-question-3), my query was a LOT longer and difficult to figure out. Now with the **```genre_count_and_avg```** table made I am able to use multiple tables to my advantage. Very useful!

### **#4: Percentage of Genres**

Considering that I am looking for the percentage of games in the top genre for Nintendo, I will need to divide the total amount of games in the Open-World genre with all games. I will also test to see the percentage of games released in the top genre out of the whole database as well.

For part 1, we need to gather the total count of games released by Nintendo. 

<br />

```sql
DROP TABLE IF EXISTS total_nintendo_games;

CREATE TEMP TABLE total_nintendo_games AS

SELECT COUNT(*) AS total_games 
FROM joined_dataset
WHERE publisher_name = 'Nintendo';

SELECT * FROM total_nintendo_games;
```
✅ **Result Part 1:**
|total_games|
|-----------|
|71         |

<br />

Now that I know there are 71 total games by Nintendo in this database, I can find the percentage by combining the **```top_genre_game_count```** table with the **```total_nintendo_games```** table. Our top genre is Open-World with a total of 6 out of 71 games. Let's create a joint table named **```percent_ow_joint_table```**. 

```sql
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
```
<br />

I was able to easily divide both numbers to get our percentage of Open-World games. I needed to convert numbers from **```game_count```** and **```total_games```** to **```float```** in order to get the approximate numerical values. Afterwards, I was able to round the decimals to 2 places using the **```CAST```** and **```numeric```** functions. 

✅ **Result Part 2:**
|percentage_open_world|
|---------------------|
|8.45                 |

<br />

For part 3 of this question lets find the percentages of all genres relative to the total games released by Nintendo. 

```sql
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
```

✅ **Result Part 3:**
|genre_id|genre_name          |percentage_genres|
|--------|--------------------|-----------------|
|22      |Platformer	      |14.08		|
|24      |RPG          	      |9.86		|
|19      |Open-World          |8.45		|
|2       |Action Adventure    |7.04		|
|41      |JRPG	              |7.04		|
|4       |Action RPG          |7.04		|
|20      |Party/Minigame      |4.23		|
|31      |Simulation          |4.23		|
|25      |Racing              |4.23		|
|3       |Action Puzzle       |4.23		|
|36      |Third-Person Shooter|4.23		|
|23      |Puzzle              |4.23		|
|14      |Fighting            |4.23		|
|38      |Turn-Based Strategy |2.82		|
|11      |Compilation         |2.82		|
|26      |Real-Time Strategy  |2.82		|
|27      |Rhythm              |1.41		|
|15      |First-Person Shooter|1.41		|
|13      |Exercise/Fitness    |1.41		|
|35      |Tactics             |1.41		|
|8       |Beat-'Em-Up 	      |1.41		|
|1       |Action 	      |1.41		|

---
## All in All
We are now in the very last part of this project! In order to visualize everything, I will create a table named **```complete_joint_dataset```** to show the **```genre_id```**, **```genre_name```**, **```percentage_genres```**, **```game_count```**, and **```avg_score```**. We will be inner joining the two tables we have made to output all the information needed.

```sql
DROP TABLE IF EXISTS complete_joint_dataset;
CREATE TEMP TABLE complete_joint_dataset AS
SELECT 
       t1.genre_id,
       t1.genre_name,
       avg_score, 
       game_count,
       percentage_genres

FROM genre_count_and_avg AS t1

INNER JOIN percent_genre_joint_table AS t2
	ON t1.genre_id = t2.genre_id;

SELECT * FROM complete_joint_dataset
ORDER BY percentage_genres DESC
LIMIT 10;
```

✅ **Result:**
|genre_id|genre_name          |avg_score|game_count|percentage_genres|
|--------|--------------------|---------|----------|-----------------|
|22      |Platformer	      |86.30	|10	   |14.08	     |
|24      |RPG          	      |80.29	|7	   |9.86	     |
|19      |Open-World          |86.67	|6	   |8.45	     |
|2       |Action Adventure    |86.40	|5	   |7.04             |
|41      |JRPG	              |84.00	|5	   |7.04	     |
|4       |Action RPG          |86.60	|5	   |7.04	     |
|3       |Action Puzzle       |86.60	|3	   |4.23	     |
|23      |Puzzle              |86.60	|3	   |4.23	     |
|14      |Fighting            |86.60	|3	   |4.23	     |
|20      |Party/Minigame      |86.60	|3	   |4.23	     |

### With All the Tables We Have Used To Answer Our Questions
*We can now see the percentages of games in comparison to all genres*
* ***Platformers making up 14.08% out of the total games in this database***
* ***RPGs making up 9.86% out of the total games in this database***
* ***Open-World making up 8.45% out of the total games in this database***

----------------------------------

<p>&copy; 2024 Ryan Dang</p>
