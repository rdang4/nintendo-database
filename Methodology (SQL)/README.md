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


---
## Table Relationships
The brainstorming process was unfamiliar to me as I was assigned the task of determining how to arrange each column to be inserted into a table. I decided to create a workflow diagram to visualize each and every table that was going to be created. You never know how much writing or visualizing your ideas helps until it is done!

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

Additionally, I would be able to calculate the **```game_count```** based on the **```genre_id```** by referencing the **```game_category```** database. 

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



---

<p>&copy; 2023 Ryan Dang</p>
