/*

GAME TABLE CREATION

NINTENDO SWITCH LIBRARY AND DATA ANALYTICS

*/

-- Table Creation: Game
  -- b. Game

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

-- All sales will be in units of a million. Sales will be taken from the VGChartz website and are rough estimates. 
-- I will also use Excel to CONCATENATE the line of code I need to enter into PostgreSQL. This saves a bunch of time rather than having to copy and paste each game information.

  -- Here is an example of what I inserted into the database:

INSERT INTO game(title, release_date, esrb, console, metascore,
                 user_score, sales_mil)
VALUES
     ('The Legend of Zelda: Breath of the Wild', '2017-03-03', 'E', 'Switch', '97',
      '8.7', '31.15'),
     ('Super Mario Odyssey', '2017-10-27', 'E10+', 'Switch', '97',
      '8.9', '26.95'),
     ('Persona 5 Royal', '2022-10-21', 'M', 'Switch', '94',
      '8.6', '4.0');

-- Result:
+─────────+─────────────────────────────────────────+──────────────+──────+─────────+───────────+────────────+───────────+
| game_id | title                                   | release_date | esrb | console | metascore | user_score | sales_mil |
+─────────+─────────────────────────────────────────+──────────────+──────+─────────+───────────+────────────+───────────+
| 1       | The Legend of Zelda: Breath of the Wild | 2017-03-03   | E    | Switch  | 97        | 8.7        | 31.150    |
| 2       | Super Mario Odyssey                     | 2017-10-27   | E10+ | Switch  | 97        | 8.9        | 26.950    |
| 3       | Persona 5 Royal                         | 2022-10-21   | M    | Switch  | 94        | 8.6        | 4.000     |
+─────────+─────────────────────────────────────────+──────────────+──────+─────────+───────────+────────────+───────────+

  -- There will be another column for details, but I omitted it to shorten the results chart.

----------------------------------------------

-- Problem/Hiccups:

/**

  The TO_DATE function. I preferred showing the name of the month followed by the number of day and then the year. 
  I did learn afterward that it was probably better to store dates in a dedicated DATE column. 

  For example: "2017-03-03" compared to "Mar-03-2017". A lot of trial and error, but I settled with the default format.
  
  Initially when creating the Game table, I set the parameters for each column to be VARCHAR. 
  This made no sense as scores and sale numbers are considered to be numerical integers. I made the changes accordingly.

**/
