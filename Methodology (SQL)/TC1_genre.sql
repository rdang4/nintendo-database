/*

GENRE TABLE CREATION

NINTENDO SWITCH LIBRARY AND DATA ANALYTICS

*/

-- Table Creation: Genre
  -- a. Genre

CREATE TABLE genre
(
  genre_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  last_update TIMESTAMP NOT NULL
);

-- I was able to find 47 genre names listed. 
-- I will list the first 5 genre names generated below:

INSERT INTO genre(name, last_update)
VALUES
  ('Action', CURRENT_TIMESTAMP),
  ('Action Adventure', CURRENT_TIMESTAMP),
  ('Action Puzzle', CURRENT_TIMESTAMP),
  ('Action RPG', CURRENT_TIMESTAMP),
  ('Adventure', CURRENT_TIMESTAMP);

  -- Let's run the query to output our work

SELECT genre_id, name FROM genre
LIMIT 5;

-- Result:
+──────────+──────────────────+────────────────────────────+
| genre_id | name             | last_update                |
+──────────+──────────────────+────────────────────────────+
| 1        | Action           | 2023-11-14 00:29:30.420746 |
| 2        | Action Adventure | 2023-11-14 00:29:30.420746 |
| 3        | Action Puzzle    | 2023-11-14 00:29:30.420746 |
| 4        | Action RPG       | 2023-11-14 00:29:30.420746 |
| 5        | Adventure        | 2023-11-14 00:29:30.420746 |
+──────────+──────────────────+────────────────────────────+
  
-- Problems/Hiccups:
  -- For the names in the genre table,  words that included apostrophes like "Beat-'Em-Up" would create or close strings.

/***

INSERT INTO genre(name, last_update)
VALUES
  ('Beat- 'Em Up', CURRENT_TIMESTAMP);

***/

  -- Beat-'Em-Up technically ends the character entry at "Beat-". If there is another single quote, it will end the string.

INSERT INTO genre(name, last_update)
VALUES
  ('Beat-''Em Up', CURRENT_TIMESTAMP);

-- Result
+──────────+────────────────+────────────────────────────+
| genre_id | name           | last_update                |
+──────────+────────────────+────────────────────────────+
| 8        | "Beat-'Em Up"  | 2023-11-14 00:29:30.420746 |
+──────────+────────────────+────────────────────────────+
  
-- Now it works! I will not show the creation for the  developer and publisher database as the overall process is the same for both.
