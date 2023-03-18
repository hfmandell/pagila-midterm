/*
 * Write a SQL query SELECT query that:
 * List the first and last names of all actors who have appeared in movies in the "Children" category,
 * but that have never appeared in movies in the "Horror" category.
 */


-- Actors that have appeared in "Children" category films
WITH c_actors AS (
    SELECT first_name, last_name, actor_id
    FROM actor
        JOIN film_actor USING (actor_id)
        JOIN film USING (film_id)
        JOIN film_category USING (film_id)
        JOIN category using (category_id)
    WHERE category.name = 'Children'
    ORDER BY last_name, first_name
),

-- Actors that have appeared in "Horror" category films
h_actors AS (
    SELECT first_name, last_name, actor_id
    FROM actor
        JOIN film_actor USING (actor_id)
        JOIN film USING (film_id)
        JOIN film_category USING (film_id)
        JOIN category using (category_id)
    WHERE category.name = 'Horror'
    ORDER BY last_name, first_name
)

-- Final Query: Actors in "Children" movies, but not "Horror" movies
SELECT first_name, last_name
FROM c_actors

EXCEPT

SELECT first_name, last_name
FROM h_actors
ORDER BY last_name, first_name;
