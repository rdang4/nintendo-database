# **[Nintendo Database Analytics - Application](https://github.com/rdang4/nintendo-database-analytics/tree/main)**

## Methodology (SQL)

<p align="center">
<img src="https://github.com/rdang4/nintendo-database-analytics/blob/main/Images/methodology_sql_1.gif" width=30% height=30%>
</p>

## Table of Contents

1. [Table Relationships](#table-relationships)

2. [Key Data Terms](#key-data-terms)

3. [Start to End Points](#start-to-end-points)

4. [Table Creation](#table-creation)

     a. [Genre Table](#a-genre)

     b. [Game Table](#b-game)

---
## Table Relationships
The brainstorming process was unfamiliar to me as I needed to determine how to arrange each column to be inserted into a table. I decided to create a workflow diagram to visualize each and every table that was going to be created. You never know how much writing or visualizing your ideas helps until it is done!

Each table is labeled from 1 to 7 to show the relationship between each dataset. Table 1 begins with **```Nintendo.genre```** and ends with Table 7 as **```Nintendo.publisher```**.

Relationships between each dataset is shown below:

<p align="center">
<img src="https://github.com/rdang4/nintendo-database-analytics/blob/main/Images/ND_Mind_Map_Text.png" width=100% height=100%>
</p>


---
## Key Data Terms
If I would like to answer my questions, I needed to figure out which data terms were going to be used in my query:

* **```genre.name```**: To name the top 3 genres
* **```game_count```**: How many game titles are within these genres?
* **```average_rating```**: Identifying the top 3 genres based on the average rating on Metacritic
* **```developer.name```**: Finding the top 3 genres published by Nintendo
* **```game.title```**: To find the most popular game titles

<br />

* **```game.esrb```**: Identifying the ESRB ratings from the game table
* **```game.sales_mil```**: Identifying the amount of sales depending on the ESRB
* **```sum_sales_mil```**: Comparing the amount of sales based on each ESRB rating

<br />

* **```average_comparison```**: Comparing how many more games were released in the top genre compared to the third top genre
* **```percentage```**: Calculated percentage of games released in the top genre compared to all other games

---
## Start to End Points
To be able to get to the **top 3 genres by a developer**, I need to create a dataset that can get from **```genre.name```** to **```developer.name```**. Therefore, in order to achieve this result, I need to find a way to connect **Table 1** **```Nintendo.genre```** all the way to **Table 5** **```Nintendo.developer```**.

<p align="center">
<img src="https://github.com/rdang4/nintendo-database-analytics/blob/main/Images/ND_Mind_Map_1.png" width=100% height=100%>
</p>

Additionally, I would be able to calculate the **```game_count```** based on the **```genre_id```** by referencing the **```game_category```** database. Every other question can also stem from the first or answered with the **```Nintendo.game```** table.

<br />

In order to start from **```Nintendo.genre```** and end at **```Nintendo.developer```** we need to find the foreign keys to join each table together.

|Table Join       |Begin               |End                 |Foreign Key       |
|-----------------|--------------------|--------------------|------------------|
|**Part 1**       |```genre```         |```game_category``` |```genre_id```    |
|**Part 2**       |```game_category``` |```game```          |```game_id```     |
|**Part 3**       |```game```          |```game_developer```|```game_id```     |
|**Part 4**       |```game_developer```|```developer```     |```developer_id```|

<br />

This resulting table join will give us our SQL output. To help me visualize it even further, I decided to split this into different steps:

<p align="center">
<img src="https://github.com/rdang4/nintendo-database-analytics/blob/main/Images/ND_Mind_Map_2.png" width=80% height=80%>
</p>

<p align="center">
<img src="https://github.com/rdang4/nintendo-database-analytics/blob/main/Images/ND_Mind_Map_3.png" width=80% height=80%>
</p>

<p align="center">
<img src="https://github.com/rdang4/nintendo-database-analytics/blob/main/Images/ND_Mind_Map_4.png" width=80% height=80%>
</p>

<p align="center">
<img src="https://github.com/rdang4/nintendo-database-analytics/blob/main/Images/ND_Mind_Map_5.png" width=80% height=80%>
</p>

---
## Table Creation
### a. Genre
Now we can get started in the creation of each database! Since I am starting from scratch, I cannot begin answering each question until I am done entering all the game titles from the Metacritic website. Let's start with the easy part; the **```Nintendo.genre```** database.

The idea is pretty much the same when creating the others. Here is what I had for **```genre```**:

 <br /> 

```sql
CREATE TABLE genre
(
  genre_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  last_update TIMESTAMP NOT NULL
);

```

 <br /> 

Now we get to add in the genres listed on the Metacritic site! I was able to find 44 genre names listed under the filter search. Since **```genre.id```** is a **SERIAL PRIMARY KEY**, every time I insert a row into the database, the **```genre.id```** will continuously count up for each update. 

> (There are a lot of games that are not within these genre names. I do not understand why, but I will do my best to associate each game in respect to the closest genre name.)

I will list the first **5 genre names** here:

 <br />

```sql
INSERT INTO genre(name, last_update)
VALUES
  ('Action', CURRENT_TIMESTAMP),
  ('Action Adventure', CURRENT_TIMESTAMP),
  ('Action Puzzle', CURRENT_TIMESTAMP),
  ('Action RPG', CURRENT_TIMESTAMP),
  ('Adventure', CURRENT_TIMESTAMP);

```
```sql
SELECT * FROM genre
LIMIT 5;
```
✅ **Result:**
|genre_id|name            |last_update               |
|--------|----------------|--------------------------|
|1       |Action          |2023-11-14 00:29:30.420746|
|2       |Action Adventure|2023-11-14 00:29:30.420746|
|3       |Action Puzzle   |2023-11-14 00:29:30.420746|
|4       |Action RPG      |2023-11-14 00:29:30.420746|
|5       |Adventure       |2023-11-14 00:29:30.420746|

 <br />
 
### 🟥 **Problems/Hiccups**:

As I was entering the values for **```genre.name```**, I noticed a problem. There are some genres that included apostrophes within their names, and naturally, this would mean it would close the character strings when entering values. Take the name ***Beat-'Em Up*** for example:

<br />
 
```sql
INSERT INTO genre(name, last_update)
VALUES
  ('Beat-'Em Up', CURRENT_TIMESTAMP),

```

 <br />
 
As shown above, the name ***“Beat-’Em-Up”*** technically ends the character entry at ***“Beat-”***. In times like these, I always check for [documentation](https://www.postgresql.org/docs/7.4/functions-string.html). When encasing the name in single quotes, it will become a string. Although, if there is another single quote, it ends the string. Therefore, we must make the apostrophe a **literal string** by using **```\s```** or **```''```** to bypass it:

 <br />
 
```sql
INSERT INTO genre(name, last_update)
VALUES
  ('Beat-''Em Up', CURRENT_TIMESTAMP),

```
✅ **Result:**
|genre_id|name            |last_update               |
|--------|----------------|--------------------------|
|8       |Beat-'Em Up     |2023-11-14 00:29:30.420746|

 <br />

Now it works! **I will not show the creation for the ```developer``` and ```publisher``` database as the overall process is the same**.

---
### b. Game
Now that I have familiarized myself with creating tables and inserting values, I moved on to the biggest one, the **```Nintendo.game```** table.

> The **```Nintendo.game```** database is the table that will take a majority of my time as there are about 1000 games rated on Metacritic. As of right now, I have the first 100 games I entered in the database which is more than enough to explain the process here.

Creating parameters for each column was very important here. I am keeping in mind what I would like to do and am adjusting on the fly. Other than researching which games were released since the start of the Nintendo Switch, the hardest part was inserting all of the titles into the database. As far as I know, there is no simple way to add the values without importing them from Excel or Google Sheets. I wanted to challenge myself by manually adding each game myself. Here is what I came up with:

 <br />
 
```sql
CREATE TABLE game
(
  game_id SERIAL PRIMARY KEY,
  title VARCHAR(500) UNIQUE NOT NULL,
  release_date DATE,
  esrb VARCHAR(10),
  console VARCHAR(50),
  metascore SMALLINT,
  user_score NUMERIC(3,1),
  sales_mil NUMERIC(5,3),
  details TEXT
);

```

 <br />

I am very much aware that some smaller games will not have the sales or general information available. To avoid any standard deviations, any games that are not known as well will be entered as **NULL** while the **games that are not rated on Metacritic will not be listed in the database**. **All sales information will be converted to units of a million.** Also, keep in mind that sales information is not readily available (for legal reasons). **Numbers of sales on the Switch console will be rough estimates according to the VGChartz website.** In the process of adding more game titles, there are games that include Skylanders Imaginators, I Am Setsuna, or Metal Slug that are ported from older consoles. I will not include sales information from these games as this project is mainly focused on first party Nintendo Switch games.

Here is an example of the values I inserted into the database:

 <br />
 
```sql
INSERT INTO game(title, release_date, esrb, console, metascore,
                 user_score, sales_mil)
VALUES
     ('The Legend of Zelda: Breath of the Wild', '2017-03-03', 'E', 'Switch', '97',
      '8.7', '31.15'),
     ('Super Mario Odyssey', '2017-10-27', 'E10+', 'Switch', '97',
      '8.9', '26.95'),
     ('Persona 5 Royal', '2022-10-21', 'M', 'Switch', '94',
      '8.6', '4.0');

```
✅ **Result:**
|game_id |title                                   |release_date|esrb|console|metascore|user_score|sales_mil|
|--------|----------------------------------------|------------|----|-------|---------|----------|---------|
|1       |The Legend of Zelda: Breath of the Wild |2017-03-03  |E   |Switch |97       |8.7       |31.150   |
|2       |Super Mario Odyssey                     |2017-10-27  |E10+|Switch |97       |8.9       |26.950   |
|3       |Persona 5 Royal                         |2022-10-21  |M   |Switch |94       |8.6       |4.000    |

 <br />

> I added another column called **```details```**, but I took it out to shorten the chart a bit.

<br />

### 🟥 **Problems/Hiccups**:

There were quite a few problems I encountered during this process.

* The **```TO_DATE```** function. I preferred showing the name of the month followed by the number of day and then the year. I did learn afterward that it was probably better to store dates in a dedicated **```DATE```** column. For example: **"2017-03-03"** compared to **"Mar-03-2017"**. A lot of trial and error, but I settled with the default format.
* Initially when creating the **```Nintendo.game```** table, I set the parameters for each column to be **```VARCHAR```**. This made no sense as scores and sale numbers are considered to be numerical integers. I made the changes accordingly.

<br />

---
Moving on to the **```game_category```** database, 








---

<p>&copy; 2023 Ryan Dang</p>
