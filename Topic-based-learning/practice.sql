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


SELECT c.first_name, c.last_name , COUNT(*) AS rent
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
GROUP BY r.customer_id,  c.first_name, c.last_name
ORDER BY rent DESC
LIMIT 5;



SELECT 
	c.first_name, 
	c.last_name,
	rc.rent
FROM customer c
JOIN (
	SELECT 
		customer_id,
		COUNT(*) AS rent
	FROM rental
	GROUP BY customer_id
) rc ON c.customer_id = rc.customer_id
ORDER BY rc.rent DESC
LIMIT 5;



-- customers who rented more than 3
-- name of the films


SELECT 
	f.title, 
	r.customer_id
FROM rental r
JOIN film f ON f.film_id = r.film_id
WHERE r.customer_id IN (
	SELECT 
		customer_id
	FROM rental
	GROUP BY customer_id
	HAVING COUNT(*) > 3
);

SELECT f.title, r.customer_id
FROM rental r
JOIN film f ON r.film_id = f.film_id
WHERE r.customer_id IN (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > 3
);


CREATE VIEW customer_rental_summary AS
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

SELECT * FROM customer_rental_summary;

DROP VIEW customer_rental_summary;






CREATE MATERIALIZED VIEW popular_films AS
SELECT f.film_id, f.title, COUNT(r.rental_id) AS total_rentals
FROM film f
JOIN rental r ON f.film_id = r.film_id
GROUP BY f.film_id
ORDER BY total_rentals DESC;


SELECT * FROM popular_films;


REFRESH MATERIALIZED VIEW popular_films;



INSERT INTO rental (customer_id, film_id, rental_date)
VALUES
(1, 5, '2025-09-25'),
(2, 6, '2025-09-26'),
(3, 7, '2025-09-27');








