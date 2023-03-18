/*
 * Write a SQL query SELECT query that:
 * computes the country with the most customers in it. 
 */

-- Create a Table that has the customer count for each country
WITH customer_count_by_country AS (
        SELECT country, count(*) FROM country
        JOIN city USING (country_id)
        JOIN address USING (city_id)
        JOIN customer USING (address_id)
        GROUP by country
        ORDER by count(*) DESC)

-- Select only the country with the most customers
SELECT country
FROM customer_count_by_country
WHERE "count" = (
    SELECT MAX("count") 
    FROM customer_count_by_country
);

