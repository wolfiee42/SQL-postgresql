SELECT 
c.first_name, c.last_name, r.film_id
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE c.first_name = 'John' AND r.film_id = 1;

SELECT *
FROM film
WHERE title ILIKE '%spider%';

SELECT *
FROM rental
WHERE film_id IN (1,2,3);

SELECT *
FROM rental
WHERE rental_date BETWEEN '2025-09-05' AND '2025-09-10';

SELECT DISTINCT rating FROM film;

SELECT 
	customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id
HAVING COUNT(*) > 3;



SELECT *
FROM film
WHERE title ILIKE '%man%';


SELECT *
FROM film
WHERE title ~ '^The';


SELECT customer_id, COUNT(*) AS rentals
FROM rental
GROUP BY customer_id;


SELECT *
FROM film
ORDER BY release_year DESC;

SELECT *
FROM customer
ORDER BY first_name ASC
LIMIT 5;



SELECT c.first_name, c.last_name, f.title 
FROM rental r
INNER JOIN customer c ON c.customer_id = r.customer_id
INNER JOIN film f ON r.film_id = f.film_id;


SELECT c.first_name, c.last_name, f.title
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
LEFT JOIN film f ON r.film_id = f.film_id;


SELECT r.customer_id , COUNT(*) AS rent
FROM rental r
GROUP BY customer_id
ORDER BY rent DESC
JOIN customer c ON r.customer_id = c.customer_;




