/*
 * You want to watch a movie tonight.
 * But you're superstitious,
 * and don't want anything to do with the letter 'F'.
 *
 * Write a SQL query that lists the titles of all movies that:
 * 1) do not have the letter 'F' in their title,
 * 2) have no actors with the letter 'F' in their names (first or last),
 * 3) have never been rented by a customer with the letter 'F' in their names (first or last).
 * 4) have never been rented by anyone with an 'F' in their address (at the street, city, or country level).
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 */

-- (1) Films with no 'f's in their titles
WITH film_ids_no_f_titles AS (
    SELECT DISTINCT film_id
    FROM film
    WHERE title NOT ILIKE '%f%'
),

-- (2) Films with no 'f's in their actor's first or last names
film_ids_no_f_actors AS (
    SELECT DISTINCT film_id 
    FROM film_actor
    JOIN actor USING (actor_id)
    WHERE first_name NOT ILIKE '%f%'
        AND last_name NOT ILIKE '%f%'
),

-- (3) Films with no 'f's in their customer's first or last names
film_ids_no_f_customers AS (
    SELECT DISTINCT film_id
    FROM inventory
    JOIN rental USING (inventory_id)
    JOIN customer USING (customer_id)
    WHERE first_name NOT ILIKE '%f%'
        AND last_name NOT ILIKE '%f%'
),

-- (4) Films with no 'f's in their customer's addresses, districts, cities, or countries
film_ids_no_f_addresses AS (
    SELECT DISTINCT film_id
    FROM inventory 
    JOIN rental USING (inventory_id)
    JOIN customer USING (customer_id)
    JOIN address USING (address_id)
    JOIN city USING (city_id)
    JOIN country USING (country_id)
    WHERE address NOT ILIKE '%f%'
        AND address2 NOT ILIKE '%f%'
        AND district NOT ILIKE '%f%'
        AND city NOT ILIKE '%f%'
        AND country NOT ILIKE '%f%'
)

-- Select only films that appear in ALL four queries above
SELECT DISTINCT title
FROM film
JOIN film_ids_no_f_titles USING (film_id)
JOIN film_ids_no_f_actors USING (film_id)
JOIN film_ids_no_f_customers USING (film_id)
JOIN film_ids_no_f_addresses USING (film_id)
ORDER BY title
;


