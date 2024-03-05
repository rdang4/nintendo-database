/*****************************************

NINTENDO SWITCH LIBRARY AND DATA ANALYTICS 

******************************************
ALL IN ALL
******************************************/

DROP TABLE IF EXISTS complete_joint_dataset;
CREATE TEMP TABLE complete_joint_dataset AS
SELECT 
       t1.genre_id,
       t1.genre_name,
       avg_score, 
       game_count,
       percentage_genres

FROM genre_count_and_avg AS t1

INNER JOIN percent_genre_joint_table AS t2
	ON t1.genre_id = t2.genre_id;

SELECT * FROM complete_joint_dataset
ORDER BY percentage_genres DESC
LIMIT 10;

-- Result: 
+──────────+────────────────────+───────────+────────────+───────────────────+
| genre_id | genre_name         | avg_score | game_count | percentage_genres |
+──────────+────────────────────+───────────+────────────+───────────────────+
| 22      | Platformer          | 86.30	    | 10         | 14.08             |
| 24      | RPG                 | 80.29	    | 7          | 9.86	             |
| 19      | Open-World          | 86.67	    | 6          | 8.45	             |
| 2       | Action Adventure    | 86.40     | 5          | 7.04              |
| 41      | JRPG                | 84.00     | 5          | 7.04	             |
| 4       | Action RPG          | 86.60	    | 5          | 7.04	             |
| 3       | Action Puzzle       | 86.60	    | 3          | 4.23	             |
| 23      | Puzzle              | 86.60	    | 3          | 4.23	             |
| 14      | Fighting            | 86.60	    | 3          | 4.23	             |
| 20      | Party/Minigame      | 86.60	    | 3          | 4.23	             |
+──────────+────────────────────+───────────+────────────+───────────────────+

/********************************************************************

FINISHING THOUGHTS:

With All the Tables We Have Used To Answer Our Questions

We can now see the percentages of games in comparison to all genres:

* Platformers making up 14.08% out of the total games in this database
* RPGs making up 9.86% out of the total games in this database
* Open-World making up 8.45% out of the total games in this database

********************************************************************/
