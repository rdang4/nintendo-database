/*

GAME CATEGORY TABLE CREATION

NINTENDO SWITCH LIBRARY AND DATA ANALYTICS

*/

-- Table Creation: Game Category
  -- a. Game Category

CREATE TABLE game_category
(
  game_id SERIAL PRIMARY KEY,
  genre_id SMALLINT,
  last_update TIMESTAMP
);

  -- I needed to find a way to transfer all the values of game_id from Game into this table. 
  -- For each game_id listed in the Game table, the genre_id will be assigned to it. This would mean that we will have multiple game ids that have the same genre.

-- Let's add the game_id column from the Game table into this table:

INSERT INTO game_category (game_id)
SELECT game.game_id
FROM game
WHERE game.game_id NOT IN (SELECT game_id FROM game_category);

  -- This shall now transfer game_id into game_category as a column.


-- Problems/Hiccups:
  -- My first thought was that I wanted to understand whether or not I was able to transfer the primary key game_id from Nintendo.game into game_category. 
  
-- This was my first shot at it:

INSERT INTO game_category (game_id)
SELECT game_id
FROM game;

  -- The problem was that if this query was being used, it would not account for the duplicate game_id being transferred. 
  -- If the primary key for game_id number 1 was transferred already, it would'nt work.\

-- Lastly, I need to update every genre_id to each respective game_id:

UPDATE game_category
SET genre_id = 5,
    last_update = CURRENT_TIMESTAMP
WHERE game_id IN (108,111,112,135,139)
    AND (genre_id IS NULL OR genre_id != 33); 

  -- I can set game_id to 5 with game ids that include those numbers. On the 5th line of that query, this checks for NULL values OR if there are duplicates.
