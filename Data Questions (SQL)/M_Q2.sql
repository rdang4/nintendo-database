/*************************************************************************

Question 2 from Methodology (SQL)

NINTENDO SWITCH LIBRARY AND DATA ANALYTICS 

**************************************************************************
Q2: What are the best games within the top 3 genres published by Nintendo?
(Find the top Metascores or User Scores to determine our recommendations)
**************************************************************************/

-- Top Metascores (Part 1) --

-- Start with creating the Top Metascores table
DROP TABLE IF EXISTS top_metascores;

CREATE TEMP TABLE top_metascores AS

SELECT game_id,
       title,
       metascore,
       genre_name
FROM joined_dataset
WHERE publisher_name = 'Nintendo';

-- Publishers filtered to Nintendo and genre names that are in the top 3 
SELECT * FROM top_metascores
WHERE genre_name IN ('Open-World', 'Action RPG', 'Action Adventure')
ORDER BY metascore DESC
LIMIT 10;

-- Result Part 1: 
+─────────+─────────────────────────────────────────────────────────────────+─────────────+──────────────────+
| game_id | title                              	 			                      | metascore   | genre_name	     |
+─────────+─────────────────────────────────────────────────────────────────+─────────────+──────────────────+
| 16      | The Legend of Zelda: Breath of the Wild  			                  | 97          | Open-World	     |
| 59      | The Legend of Zelda: Tears of the Kingdom			                  | 96          | Open-World	     |
| 73      | Xenoblade Chronicles 3: Expansion Pass Wave 4 - Future Redeemed | 92          | Action RPG	     |
| 71      | Bayonetta 2							                                        | 92          | Action Adventure |
| 96      | Xenoblade Chronicles: Definitive Edition			                  | 89          | Action RPG	     |
| 98      | Xenoblade Chronicles 3					                                | 89          | Action RPG	     |
| 142     | The Legend of Zelda: Link's Awakening 	                        | 87          | Open-World	     |
| 136     | Astral Chain                                                    | 87          | Action Adventure |
| 183     | Luigi's Mansion 3                                               | 86          | Action Adventure |
| 174     | Bayonetta 3							                                        | 86          | Action Adventure |
+─────────+─────────────────────────────────────────────────────────────────+─────────────+──────────────────+

-- Top User Scores (Part 2) --

-- Start with creating the Top User Scores table
DROP TABLE IF EXISTS top_user_scores;

CREATE TEMP TABLE top_user_scores AS

SELECT game_id,
       title,
       user_score,
       genre_name
FROM joined_dataset
WHERE publisher_name = 'Nintendo';

-- Publishers filtered to Nintendo, next we filter the genre names that are in the top 3 from Q1 
SELECT * FROM top_user_scores
WHERE genre_name IN ('Open-World', 'Action RPG', 'Action Adventure')
ORDER BY user_score DESC
LIMIT 10;  

-- Result Part 2:
+─────────+─────────────────────────────────────────────────────────────────+─────────────+──────────────────+
| game_id | title                              	 			                      | user_score  | genre_name	     |
+─────────+─────────────────────────────────────────────────────────────────+─────────────+──────────────────+
| 71      | Bayonetta 2			  	 			                                      | 8.9         | Action Adventure |
| 73      | Xenoblade Chronicles 3: Expansion Pass Wave 4 - Future Redeemed | 8.9         | Action RPG	     |
| 136     | Astral Chain						 	                                      | 8.9         | Action Adventure |
| 96      | Xenoblade Chronicles: Definitive Edition			                  | 8.8         | Action RPG	     |
| 16      | The Legend of Zelda: Breath of the Wild			                    | 8.7         | Open-World	     |
| 904     | Bayonetta Origins: Cereza and the Lost Demon	  		            | 8.5         | Action Adventure |
| 98      | Xenoblade Chronicles 3				  	                              | 8.5         | Action RPG	     |
| 326     | Xenoblade Chronicles 2					                                | 8.5         | Action RPG	     |
| 961     | Xenoblade Chronicles 2: Torna ~ The Golden Country		          | 8.5         | Action RPG	     |
| 142     | The Legend of Zelda: Link''s Awakening				                  | 8.4         | Action Adventure |
+─────────+─────────────────────────────────────────────────────────────────+─────────────+──────────────────+

/*******************************************

RECOMMENDATIONS:

Based on Metascores for Category: Open-World

This would be my recommendation to you:
* The Legend of Zelda: Breath of the Wild
* The Legend of Zelda: Tears of the Kingdom
* The Legend of Zelda: Link's Awakening

--------------------------------------------

Based on User Scores for Category: RPG

This would be my recommendation to you:
* Pokemon Legends: Arceus
* Paper Mario: The Origami King
* Pokemon: Let's Go, Eevee!

*******************************************/
