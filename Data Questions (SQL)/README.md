# Nintendo Switch Library and Data Analytics: Data Questions (SQL)

### ❕ Question 1

**What are the top 3 genres of all games published by Nintendo?**

When deciding on what important identifiers are going to be used in this case, I went back to the [Table Relationships](#table-relationships) section to see what I can implement. The most important part of this question was to generate the **```genre_count```** of all genres and out of all of them, only **display games that were published by Nintendo**.

Specifically, I will have to:

> INNER JOIN the **game_category** and **genre** tables with the **publisher** and **game_publisher** table in order to match each **```genre_id```** to its publisher. Afterwards, I will be able to narrow the results according to Nintendo.

<br />
 
```sql
SELECT game.game_id, game.title, game.esrb, game.metascore, game.user_score,
	   game_publisher.publisher_id, publisher.name, genre.genre_id, genre.name 
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
ORDER BY game_id;  
```
> With all the tables inner joined, I am now able to see the result of all games released by Nintendo specifically. I can fully visualize all the information laid in front of me. We will now move on to the **top 3 genres** where I will be creating **```avg_score```**.

```sql
SELECT genre.genre_id, genre.name, 
	ROUND(AVG(game.metascore),2) AS avg_score,
	COUNT(game.title) AS game_count
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
GROUP BY publisher.name, genre.name, genre.genre_id
HAVING COUNT(genre.genre_id) > 3

ORDER BY avg_score DESC
LIMIT 5;  
```
> We select **genre_id** and **name** from the genre table and the **average** of every metascore which will be named **```avg_score```**. When displaying the output for the average metascore, there were **trailing zeros** at the end of each rating. I decided to take a look at the documentation and found that **```ROUND(AVG(), 2)```** does a great job. This means that I am able to round the number to at most 2 decimal places.

> It is important to specify **Nintendo** using the **WHERE** clause from the **publisher table** in order to gather results of those rows. Then group duplicate **publisher names**, **genre names**, and **genre_id**. I decided to add another column named **```game_count```** in order to count how many games were added into the average. I also only took into consideration genres that had **more than 3** games in it to avoid a skewed average as it heavily affects the result. Here is the output I got:

✅ **Result:**
|genre_id|name                |avg_score  |game_count|
|--------|--------------------|-----------|----------|
|19      |Open-World	      |86.67      |6	     |
|4       |Action RPG          |86.60      |5	     |
|2       |Action Adventure    |86.40      |5	     |
|22      |Platformer	      |86.30      |10	     |
|41      |JRPG	              |84.00      |5	     |

<br />

There is our answer for Question 1! **The top 3 genres published by Nintendo are Open-World, Action RPG, and Action Adventure titles**. Before diving into this question, I initially hypothesized that Platformers were going to be the top rated genre, but to my surprise Open-World genres were the best by Nintendo. This makes sense with the success of The Legend of Zelda franchise.

<br />

### ❕ Question 2

**Which games are the most popular out of those 3 genres?**

So our next question tasks us with finding a more specific result out of the output from Question 1. Rather than look through and count all games published by Nintendo again, I have already found the top 3 genres: Open-World, Action RPG, and Action Adventure. 

We can interpret this question multiple different ways:

> We can use the **Metacritic ratings, user scores, or game sales** to find the most popular games. Since there is no accurate way of finding ALL game sales on the market, I will omit this from my findings. I decided to go with both ratings as the user scores represent the game audience while Metacritic scores is solely based on the opinions of the team associated with the website.

I reused the same query as Question 1 but with a few tweaks to better represent this question:

<br />
 
```sql
SELECT game.title, game.metascore, genre.name AS genre_name
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
AND genre.name IN ('Open-World', 'Action RPG', 'Action Adventure')

ORDER BY metascore DESC
LIMIT 10;
```
> Since the question asks for the most popular games, the most important columns to use will be **game.title** and **game.metascore** from the game table. This is **part 1** of the question.

✅ **Result Part 1:**
|title                              	 			|metascore   |genre_name	  |
|---------------------------------------------------------------|------------|--------------------|
|The Legend of Zelda: Breath of the Wild  			|94          |Open-World	  |
|The Legend of Zelda: Tears of the Kingdom			|90          |Open-World	  |
|Xenoblade Chronicles 3: Expansion Pass Wave 4 - Future Redeemed|89          |Action RPG	  |
|Bayonetta 2							|89          |Action Adventure	  |
|Xenoblade Chronicles: Definitive Edition			|88          |Action RPG	  |
|Xenoblade Chronicles 3						|88          |Action RPG	  |
|The Legend of Zelda: Link's Awakening			  	|88          |Open-World	  |
|Astral Chain							|87          |Action Adventure	  |
|Luigi's Mansion 3						|85          |Action Adventure	  |
|Bayonetta 3							|81          |Action Adventure	  |

<br />

> There we go! The most popular games out of the Open-World, Action RPG, and Action Adventure genre published by Nintendo. I am a fan of The Legend of Zelda series since its initial release on the Nintendo Switch and with the new entry Tears of the Kingdom, it is crazy how the Switch is able to handle such a big game. I have not played Xenoblade Chronicles, but I hear a lot about how great it is and it shows!

Now for part 2, I will gather the most popular games published by Nintendo within the top 3 genres listed above using the user scores:

<br />
 
```sql
SELECT game.title, game.user_score, genre.name AS genre_name
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
AND genre.name IN ('Open-World', 'Action RPG', 'Action Adventure')

ORDER BY user_score DESC
LIMIT 10;
```
> The most important columns to use will be **game.title** and **game.user_score** from the game table. This is **part 2** of the question.

✅ **Result Part 2:**
|title                              	 			|user_score  |genre_name	  |
|---------------------------------------------------------------|------------|--------------------|
|Bayonetta 2				 			|8.9         |Action Adventure	  |
|Xenoblade Chronicles 3: Expansion Pass Wave 4 - Future Redeemed|8.9         |Action RPG	  |
|Astral Chain							|8.9         |Action Adventure	  |
|Xenoblade Chronicles: Definitive Edition			|8.8         |Action RPG	  |
|The Legend of Zelda: Breath of the Wild			|8.7         |Open-World	  |
|Bayonetta Origins: Cereza and the Lost Demon			|8.5         |Action Adventure	  |
|Xenoblade Chronicles 3						|8.5         |Action RPG	  |
|Xenoblade Chronicles 2						|8.5         |Action RPG	  |
|Xenoblade Chronicles 2: Torna ~ The Golden Country		|8.5         |Action RPG	  |
|Luigi's Mansion 3						|8.4         |Action Adventure	  |

<br />

It seems that players really love the Xenoblade Chronicles title as it has dominated the top 10. Bayonetta as a classic on the top of the list as well. I am not surprised that this was the result as these are all really good games that I want to try myself. 

<br />

### ❕ Question 3

**More Specific Questions**

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
