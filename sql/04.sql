/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query SELECT query that:
 * Lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 * (You may choose to either include or exclude the movie 'AMERICAN CIRCUS' in the results.)
 */

-- Find actors in AMERICAN CIRCUS
WITH am_circus_actors AS (
        SELECT actor_id, film_id
        FROM film_actor
        WHERE film_actor.film_id IN (
                SELECT film_id 
                FROM film 
                WHERE title= 'AMERICAN CIRCUS'
                )
),

-- Find film_ids with 2 or more actors from AMERICAN CIRCUS 
films_with_2_or_more_ac_actors AS (
        SELECT film_actor.film_id
        FROM am_circus_actors
        JOIN film_actor USING(actor_id)
        GROUP BY film_actor.film_id
        HAVING COUNT(am_circus_actors.actor_id) >= 2
)

-- Only select film titles with the above query criteria met 
SELECT title FROM film
JOIN films_with_2_or_more_ac_actors USING (film_id)
ORDER BY title;
