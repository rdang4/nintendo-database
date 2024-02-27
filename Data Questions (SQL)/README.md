# Nintendo Switch Library and Data Analytics: Data Questions (SQL)

## Table of Contents

* [Approach to the Problems](#approach-to-the-problems)
   * [Question 1: Top 3 Genres by Nintendo](#q1-top-3-genres-by-nintendo)
   * [Question 2: Best Games From Those Top 3 Genres](#q2-best-games-in-top-3-genres)
   * [Question 3: More Specific Questions](#q3-more-specific-questions)


---
## Approach to the Problems
With the combined data readily available, we can now leverage the unified table to answer any questions I might have. This process involved meticulously analyzing and connecting each table based on their underlying relationships.

## Q1: Top 3 Genres by Nintendo
### **#1: Joined Dataset**

The most important part of this question was to generate the **```genre_count```** of all genres and out of all of them, only **display games that were published by Nintendo**. With our **```joined_dataset```**, I am able to create another table that uses this dataset to output our **```genre_count```** that we are looking for.

```sql
DROP TABLE IF EXISTS joined_dataset;

CREATE TEMP TABLE joined_dataset AS
SELECT game.game_id, game.title, genre.genre_id, genre.name AS genre_name,
	   game.esrb, game.metascore, game.user_score, publisher.name AS publisher_name, 
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

SELECT genre_id, genre_name, 
	   ROUND(AVG(metascore),2) AS avg_score,
	   COUNT(title) AS game_count
FROM joined_dataset
WHERE publisher_name = 'Nintendo'
GROUP BY publisher_name, genre_name, genre_id
HAVING COUNT(genre_id) > 3;

-- Output the highest average score with more than 3 games in descending order
SELECT * FROM genre_count_and_avg
ORDER BY avg_score DESC;
```

✅ **Result:**
|genre_id|name                |avg_score  |game_count|
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

SELECT game_id, title, metascore, genre_name
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

SELECT game_id, title, user_score, genre_name
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

### Based on User Scores for Category: **RPG**
*This would be my recommendation to you based on **User Scores** for **Nintendo games**:*
* ***Pokemon Legends: Arceus***
* ***Paper Mario: The Origami King***
* ***Pokemon: Let's Go, Eevee!***

---


## Q3: More Specific Questions

> I decided to ask myself more questions in this section in order to learn more and get accustomed to different key words and parameters. 


* **Question 3.1: Does the ESRB rating affect the amount of sales of Nintendo games?**


With the amount of data I was able to gather for game sales on the Switch, will the ESRB rating have more sales? 

> I hypothesize that ESRB ratings with an E or E10+ will garner more sales because of the amount of children that do play Nintendo games. Looking at the Super Mario Bros. series, it seems like a safe bet.

The goal of this question is to **gather the total amount of sales of all games in the database for each ESRB rating (E, E10+, T, and M)**. I will denote the total game sales as **```total_sales```**.

<br />

```sql
SELECT game.esrb,
     SUM(sales_mil) AS total_sales
     FROM game
GROUP BY esrb
ORDER BY total_sales DESC;
```
> This question will only involve the game table, therefore I do not need to do any joins to get my solution. This was relatively simple now that I worked out the problem, but here is my output!

✅ **Result:**
|esrb    |total_sales     |
|--------|----------------|
|RP      |[null]          |
|E       |328.330         |
|E10+    |184.400         |
|T       |36.560 	  |
|M       |13.520          |

> And just as expected my hypothesis was correct! With so many popular games released with an ESRB rating of E and E10+, it makes sense that the **```total_sales```** in millions will be at the top of the list. The ESRB rating of **RP means Rating Pending**, therefore it does not have a rating yet. We will ignore RP because there is no value for it. 

<br />

* **Question 3.2: How many games did Nintendo release in their top genre?**

Now, if I started fresh without joining all the tables in the previous question, the process would be the same, but this time we are counting up the amount of genres to denote the amount of games that have the Open-World tag.

<br />

```sql
SELECT genre.name, COUNT(*) AS genre_count
	FROM game

INNER JOIN game_category
	ON game.game_id = game_category.game_id
INNER JOIN genre
	ON game_category.genre_id = genre.genre_id
INNER JOIN game_publisher
	ON game.game_id = game_publisher.game_id
INNER JOIN publisher
	ON game_publisher.publisher_id = publisher.publisher_id
	
WHERE publisher.name = 'Nintendo'
AND genre.name IN ('Open-World')
GROUP BY publisher.name, genre.name;
```

✅ **Result:**
|name            |genre_count|
|----------------|-----------|
|Open-World      |6          |

> With **```genre_count```** listed, we now know that the total amount of games in the Open-World genre published by Nintendo is 6.

<br />

* **Question 3.3: How many more games were released in the top genre compared to the third top genre?**

This will involve basic arithmetic and since there will not be a significant amount of numbers to make the math as complicated as possible, I will do it anyway. Referring back to [Question 1](#-question-1) above, our top 3 genres were; Open-World, Action RPG, and Action Adventure. 

<br />

```sql
SELECT
	(SELECT COUNT(*) FROM game 
	 INNER JOIN game_category
		ON game.game_id = game_category.game_id
	 INNER JOIN genre
		ON game_category.genre_id = genre.genre_id
	 INNER JOIN game_publisher
		ON game.game_id = game_publisher.game_id
	 INNER JOIN publisher
		ON game_publisher.publisher_id = publisher.publisher_id
	 WHERE publisher.name = 'Nintendo' AND genre.name = 'Open-World'
	 GROUP BY publisher.name, genre.name) - 
	(SELECT COUNT(*) FROM game 
	 INNER JOIN game_category
		ON game.game_id = game_category.game_id
	 INNER JOIN genre
		ON game_category.genre_id = genre.genre_id
	 INNER JOIN game_publisher
		ON game.game_id = game_publisher.game_id
	 INNER JOIN publisher
		ON game_publisher.publisher_id = publisher.publisher_id
	 WHERE publisher.name = 'Nintendo' AND genre.name = 'Action Adventure'
	 GROUP BY publisher.name, genre.name) 

AS difference;
```
✅ **Result:**
|difference      |
|----------------|
|1	         |

> Open-World has 6 games and Action Adventure has 5 games in my database. This means that the difference displayed in our result is correct! It was A LOT harder than I expected because subtracting from the same column is difficult compared to two different columns.

> The hardest part was figuring out where to start subtracting in the first place as I was never really tought how to do this specifically. Finding the **difference of 2 rows in the same column** required me to create **extra SELECT statements** in parenthesis to be able to get the game count of both Open-World and Action Adventure. Since I cannot select two columns to subtract with, I had to find the count of each genre individually AND THEN subtract them. WOW this was a tedious question!

<br />

* **Question 3.4: What is the percentage of games released in the top category compared to all other categories?**

Considering that I am looking for the percentage of games in the top category for Nintendo, I will need to divide the total amount of games published with the Platformers genre. Since this question is a general one, I will test to see the percentage of games released in the top category in the whole database as well.

For part 1, I will need to find the total amount of games by Nintendo first:

<br />

```sql
SELECT COUNT(*) AS total_games
	FROM game
	
INNER JOIN game_category
	ON game.game_id = game_category.game_id
INNER JOIN genre
	ON game_category.genre_id = genre.genre_id
INNER JOIN game_publisher
	ON game_category.game_id = game_publisher.game_id
INNER JOIN publisher
	ON game_publisher.publisher_id = publisher.publisher_id
	
WHERE publisher.name = 'Nintendo'
GROUP BY publisher.name;
```
✅ **Result Part 1:**
|total_games|
|-----------|
|71         |

Now that I know there are 71 total games by Nintendo in this database, I can find the percentage by using some information I gathered from previous questions. Our top genre is Open-World with a total of 6 games. **We should have around 8.5% as our sample output**.

```sql
SELECT ROUND(6.0 / COUNT(*), 4) * 100 AS percent_ow
	FROM game

INNER JOIN game_category
	ON game.game_id = game_category.game_id
INNER JOIN genre
	ON game_category.genre_id = genre.genre_id
INNER JOIN game_publisher
	ON game.game_id = game_publisher.game_id
INNER JOIN publisher
	ON game_publisher.publisher_id = publisher.publisher_id
	
WHERE publisher.name = 'Nintendo';
```
> After some brief struggling and research I was unable to figure out how to get the **COUNT** of the Open-World genre games as well as the **COUNT** of all games by Nintendo. I decided to use 6.0 from previous queries and divided this by the total, multiplied by 100 to get the percent value.

✅ **Result Part 2:**
|percent_ow|
|----------|
|8.4500    |

<br />
