# **[Nintendo Switch Library and Data Analytics](https://github.com/rdang4/nintendo-database-analytics)**

# Data Join - Methodology
If I were to describe what a table join is in SQL; it allows us to combine multiple information from tables together. In this query below, I will be using **INNER JOINS** which only produces a set of records present in the tables being joined. **In this case our tables will be: game, game_category, genre, developer, game_developer, publisher, and game_publisher.** Here is a diagram of how inner joins work:

<p align="center">
<img src="https://github.com/rdang4/nintendo-database-analytics/blob/main/Images/Inner_Join_Diagram.png" width=60% height=60%>
</p>

> In this case, we have a total of 7 tables. Each table that is being inner joined like genre and game_category, they will be joined together because they both have game_id. Putting these two together will only display columns that these two tables have in common.

## **Table of Contents**

1. [Table Join](#table-join)

<br />

## **Table Join**
With our hard work done, I am now able to join all the tables together to create a clean chart for me to view.

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
<br />

✅ **Result:**
|game_id |title                                                      |genre_id |genre_name          |esrb |metascore|user_score|publisher_name   |developer_name        |
|--------|-----------------------------------------------------------|---------|--------------------|-----|---------|----------|-----------------|----------------------|
|1       |The Legend of Zelda: Breath of the Wild                    |19       |Open-World          |E10+ |97       |8.7       |Nintendo         |Nintendo              |
|2       |Super Mario Odyssey                                        |22       |Platformer          |E10+ |97       |8.9       |Nintendo         |Nintendo              |
|3       |The House in Fata Morgana - Dreams of the Revenants Edition|40       |Visual Novel        |M    |96       |8.6       |Limited Run Games|HuneX                 |
|4       |The Legend of Zelda: Tears of the Kingdom                  |19       |Open-World          |E10+ |96       |8.3       |Nintendo         |Nintendo              |
|5       |Portal: Companion Collection                               |23       |Puzzle              |T    |95       |8.7       |Valve Software   |Valve Software        |
|6       |Persona 5 Royal                                            |41       |JRPG                |M    |94       |8.6       |Atlus            |Atlus                 |
|7       |Metroid Prime Remastered                                   |15       |First-Person Shooter|T    |94       |8.7       |Nintendo         |Retro Studios         |
|8       |Tetris Effect: Connected                                   |23       |Puzzle              |E    |94       |7.6       |Enhance Games    |Monstars Inc. Resonair|
|9       |Divinity: Original Sin II - Definitive Edition             |24       |RPG                 |M    |93       |8.1       |Supegiant Games  |Larian Studios Games  |
|10      |Undertale                                                  |41       |JRPG                |E10+ |93       |8.5       |tobyfox          |tobyfox               |

<br />

**Finishing Thoughts:**

I am excited to be done with a majority of the work! With so much effort put into the [Methodology](https://github.com/rdang4/nintendo-database-analytics/tree/main/Methodology%20(SQL)) portion of this project, I am so happy to see the results from it. There is still so much to learn, but I am very satisfied with what I can accomplish after taking a course. 

<br />

## **What's Next?**

### **With all the table joining out of the way, we can use this information to our advantage on our problems to come. Let's move on to the questions portion of this project!**

<br />

**WIP:** 

[<img src="https://github.com/rdang4/nintendo-database-analytics/blob/main/Images/view_icon2.png" width=20% height=20%>](https://github.com/rdang4/nintendo-database-analytics/tree/main/Data%20Questions%20(SQL))

**First Part of the Project:**

[<img src="https://github.com/rdang4/nintendo-database-analytics/blob/main/Images/view_icon1.png" width=22% height=22%>](https://github.com/rdang4/nintendo-database-analytics/tree/main/Methodology%20(SQL))

**Main Folder:**

[<img src="https://github.com/rdang4/nintendo-database-analytics/blob/main/Images/view_icon3.png" width=20% height=20%>](https://github.com/rdang4/nintendo-database-analytics/tree/main)


--------------------------------

<p>&copy; 2024 Ryan Dang</p>
