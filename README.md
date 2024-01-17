# Nintendo Switch Library and Data Analytics

<p align="center">
<img src="https://media1.giphy.com/media/PkKjXRfMCxnRMHQWqE/giphy.gif" width=40% height=40%>

A personal passion project that showcases database collection of Nintendo games. Information will include; game titles, genre, ratings, sales, and more.

> **Updates (01/09/2024): Almost beginning to answer the main questions under [Questions & Challenges](#questions--challenges-). I finished the publisher and developer table! :D**


# Table of Contents 📋

1. [Introduction](#introduction-) 📝

2. [Questions & Challenges](#questions--challenges-) ❗

3. [Data Overview](#data-overview-%EF%B8%8F) 🗂️

4. [Citations](#citations-) 🧾

   a. [About the Gaming Industry](#about-the-gaming-industry)

   b. [The Project](#the-project)

# Introduction 📝
This is a personal project that explores the entirety of Nintendo Games Library. Therefore, these games will only involve consoles that are developed by Nintendo exclusively. I will be documenting each video game along with information related to it. **What I want to get out of this project is:**
  * To apply my knowledge acquired during formal education.
  * To showcase my skills in being able to mine, create, then visualize large amounts of data.
  * To see how far I can take my skills in using SQL and other softwares such as Tableau and STATA.
  * Which games sold the most units? Does ESRB rating affect the amount of sales? Which genre is the most popular? (Will get more specific later).

>	As we head into the next year of gaming, I wanted to know how the gaming industry was doing and what type of games were being released in 2024. I usually take note of a few upcoming games and wishlist old ones just in case they go on sale. I remember talking about this to my friends at the time, and funny enough, the YouTube algorithm decided to hit me with a [video about 2023 being “a bad year for gaming”](https://www.youtube.com/shorts/evknEWzEBaQ). Upon further research, we have seen more than 6000 estimated jobs affected since the start of the year. The highest number of workers affected was from Unity, which was evident due to the recent pricing changes on their platform. [The New York Times](https://www.nytimes.com/2023/10/02/technology/how-a-pricing-change-led-to-a-revolt-by-unitys-video-game-developers.html#:~:text=Trip%20Hawkins%2C%20the%20founder%20of,ever%20pounded%20into%20a%20wall.) quoted Trip Hawkins, the founder of Electronic Arts, as saying, "It's like a hardware store selling a carpenter a hammer and nails and then charging a fee for every nail the carpenter has ever pounded into a wall." This puts into perspective how unfair it can be for small companies/game devs that make a living off of creating games. Rather than pay a licensing fee for the overall use of Unity, they are forced to pay a fee for each sale made from their games.

>	I wanted to share my findings and bring this to light on how significant changes from big companies can negatively affect the lives of hard working game developers and employees. Although it is difficult to hear about major company decisions and recent layoffs, that is not the main focus of this project. If you would like more information about this, I suggest taking a look at the videos, articles, and statistics in the [citations](#citations-).

Now onto the project! This will be the beginning of my first personal project involving a company that we all know and love, Nintendo. I do not know anyone that has not heard of the name, especially with the new [Super Mario Bros. Movie](https://www.thesupermariobros.movie) that released in April. As someone who has adored gaming ever since I was a child, this is a big passion project for me. This task will be challenging, but I am confident that I can complete it while utilizing everything I have learned in school and through my own personal experiences. As of today, I am still in the process of learning Python as my next language of choice. I figured I would expand my horizons after finishing my online course in SQL. Depending on how the database is created, I will be able to apply the same methodology using other languages, which I will document in different sections of this paper.

To avoid a library that is massively unorganized, I’ll begin with games released from the Nintendo Switch console and MAYBE move backwards (Switch, Wii U, 3DS, etc.). I will also be gathering ratings from [Metacritic](https://www.metacritic.com) and sales data from [VGChartz](https://www.vgchartz.com). I am aware that not all the games and sales will be listed. Game data will be gathered from the Metacritic site which has only collected about 2000 results for the Nintendo Switch. Once the database is created, I can really start to have some fun. I can take this in many directions using SQL for example. Maybe I'll see which Nintendo games were released from 2020 to 2023, or which ones had the best ratings in those years. As games are continuously being released, there will be new data constantly added to the chart. How long the chart will be updated is a question I will have to encounter eventually. For now, I will take this as an opportunity to learn. 



# Questions & Challenges ❗
There are a few questions that I would like to create in order to challenge myself:

* ❕ Question 1: Top 3 Genres 

   **What are the top 3 genres of all games published by Nintendo?**

* ❕ Question 2: Popular Games 

   **Which games are the most popular out of those 3 genres?**

* ❕ Question 3: More Specific Questions
<details>
<summary>
Click to View Specific Questions
</summary>

I want to create more questions out of the top 3 genres in order to find out what this data can tell me specifically.

1. Does the ESRB rating affect the amount of sales of Nintendo games?

2. How many games did Nintendo release in their top genre?

3. How many more games were released in the top genre compared to the third top genre?

4. What is the percentage of games released in the top category compareed to all other categories?

</details>


# Data Overview 🗂️


# Citations 🧾
### About the Gaming Industry
<details>
<summary>
Click to View
</summary>
 
[Problems with the Gaming Industry in 2023](https://www.youtube.com/shorts/evknEWzEBaQ)

[More Information About Layoffs](https://www.axios.com/2023/10/12/2023-video-game-developer-layoffs)

[NY Times Article on Unity Licensing Changes](https://www.nytimes.com/2023/10/02/technology/how-a-pricing-change-led-to-a-revolt-by-unitys-video-game-developers.html#:~:text=Trip%20Hawkins%2C%20the%20founder%20of,ever%20pounded%20into%20a%20wall)

[Statistical Evaluation of Layoffs and Even More Sources](http://videogamelayoffs.com)
</details>

### The Project
<details>
<summary>
Click to View
</summary>
 
[Metacritic Ratings](https://www.metacritic.com/browse/game/nintendo-switch/all/all-time/metascore/?platform=nintendo-switch&releaseYearMin=1910&releaseYearMax=2023&page=1)

[History of All Nintendo Console Products](https://www.pocket-lint.com/nintendo-games-consoles-complete-history/)

[List of Games Released by Year](https://www.switchscores.com/games/by-date/2017-03)

[Sales Information by VGChartz](https://www.vgchartz.com/gamedb/)

[Official Nintendo Site](https://www.nintendo.com/us/store/games/nintendo-switch-games/#sort=df)

[PostgreSQL Documentation](https://www.postgresql.org/docs/)

[Mind Map Made in Canva](https://www.canva.com/design/DAF07reEg8w/MCEiJaX7jP06fwuHWwH5sQ/edit?utm_content=DAF07reEg8w&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)
</details>
