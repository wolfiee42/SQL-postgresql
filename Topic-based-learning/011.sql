	CREATE TYPE ROLE AS ENUM ('admin', 'user');

	CREATE TABLE users (
	-- name type constrains
	id SERIAL PRIMARY  
	)

	SELECT * FROM users;

	SELECT id, name, email, dob FROM users;

	SELECT id AS user_id, name AS full_name, email from users;

	SELECT 
		id,
		UPPER(name) AS full_name,
		LENGTH(name) AS name_length
	FROM users;

	SELECT 
		post_id, 
		count,
		count * 10 AS estimated_reach
	FROM post_views;

	SELECT id, name, email, dob, EXTRACT(year FROM dob) AS birth_year FROM users;

	SELECT 
		name,
		'User: ' || name AS display_name
	FROM users;

	SELECT 
		name, 
		role,
		COALESCE(bio, 'no biograghy provided.') as biography
	FROM users;












	