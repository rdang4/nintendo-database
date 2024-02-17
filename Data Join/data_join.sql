/***************************

DATA JOIN

NINTENDO SWITCH LIBRARY AND DATA ANALYTICS

****************************/

-- Data Join
  -- Creating a combined temporary table to eliminate the hassle of individually typing each column's table name

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

-- Result:
+────────+─────────────────────────────────────────────────────────────+──────────+──────────────────────+──────+───────────+────────────+───────────────────+────────────────────────+
|game_id |title                                                        | genre_id | genre_name           | esrb | metascore | user_score | publisher_name    | developer_name         |
+────────+─────────────────────────────────────────────────────────────+──────────+──────────────────────+──────+───────────+────────────+───────────────────+────────────────────────+
| 1      | The Legend of Zelda: Breath of the Wild                     | 19       | Open-World           | E10+ | 97        | 8.7        | Nintendo          | Nintendo               |
| 2      | Super Mario Odyssey                                         | 22       | Platformer           | E10+ | 97        | 8.9        | Nintendo          | Nintendo               |
| 3      | The House in Fata Morgana - Dreams of the Revenants Edition | 40       | Visual Novel         | M    | 96        | 8.6        | Limited Run Games | HuneX                  |
| 4      | The Legend of Zelda: Tears of the Kingdom                   | 19       | Open-World           | E10+ | 96        | 8.3        | Nintendo          | Nintendo               |
| 5      | Portal: Companion Collection                                | 23       | Puzzle               | T    | 95        | 8.7        | Valve Software    | Valve Software         |
| 6      | Persona 5 Royal                                             | 41       | JRPG                 | M    | 94        | 8.6        | Atlus             | Atlus                  |
| 7      | Metroid Prime Remastered                                    | 15       | First-Person Shooter | T    | 94        | 8.7        | Nintendo          | Retro Studios          |
| 8      | Tetris Effect: Connected                                    | 23       | Puzzle               | E    | 94        | 7.6        | Enhance Games     | Monstars Inc. Resonair |
| 9      | Divinity: Original Sin II - Definitive Edition              | 24       | RPG                  | M    | 93        | 8.1        | Supegiant Games   | Larian Studios Games   |
| 10     | Undertale                                                   | 41       | JRPG                 | E10+ | 93        | 8.5        | tobyfox           | tobyfox                |
+────────+─────────────────────────────────────────────────────────────+──────────+──────────────────────+──────+───────────+────────────+───────────────────+────────────────────────+



-- Counting Games
  -- Create a temporary table of our joined data with columns of total_games plus their earliest and latest releases

DROP TABLE IF EXISTS total_database_count_and_releases;

CREATE TEMP TABLE total_database_count_and_releases AS

SELECT genre.genre_id, genre.name AS genre_name, game.game_id, 
	   game.title, game.esrb, game.metascore, game.user_score,
	   publisher.name AS publisher_name, developer.name AS developer_name,
	   game.release_date
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

-- since there will be multiple rows of genre names, we can GROUP BY genre_name and genre_id to count the total_games
-- MIN and MAX is used to find the earliest and latest dates from the table.

SELECT genre_id, genre_name, COUNT(*) AS total_games,
	MIN(release_date) AS earliest_release, 
	MAX(release_date) AS latest_release
FROM total_database_count_and_releases
GROUP BY genre_name, genre_id
ORDER BY total_games DESC
LIMIT 10;

-- Result:
+──────────+─────────────────────+─────────────+──────────────────+────────────────+
| genre_id | genre_name          | total_games | earliest_release | latest_release |
+──────────+─────────────────────+─────────────+──────────────────+────────────────+
| 22       | Platformer	         | 94          | 2017-03-03       | 2023-10-20     |
| 5        | Adventure           | 42          | 2017-10-06       | 2023-12-05     |
| 2        | Action Adventure    | 37          | 2017-04-13       | 2023-10-26     |
| 11       | Compilation         | 37          | 2017-11-21       | 2023-06-30     |
| 4        | Action RPG          | 36          | 2017-12-01       | 2023-11-16     |
| 41       | JRPG                | 34          | 2017-03-03       | 2023-11-17     |
| 40       | Visual Novel        | 26          | 2017-05-11       | 2023-09-08     |
| 24       | RPG                 | 22          | 2017-10-05       | 2023-07-18     |
| 46       | Shoot-'Em-Up        | 19          | 2017-09-07       | 2023-08-17     |
| 38       | Turn-Based Strategy | 19          | 2017-03-28       | 2023-10-05     |
+──────────+─────────────────────+─────────────+──────────────────+────────────────+



   
