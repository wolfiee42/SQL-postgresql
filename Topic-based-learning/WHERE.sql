
SELECT * FROM users
WHERE name = 'Saiful Islam';

SELECT * FROM users
WHERE id = 3;

SELECT id, name, dob FROM users WHERE dob > '1990-01-01';

SELECT * FROM posts WHERE created_at < CURRENT_TIMESTAMP;

SELECT * FROM users WHERE name LIKE 'A%'; -- case sensitive
SELECT * FROM users WHERE name ILIKE 'A%'; -- case insensitive


SELECT * FROM users;

SELECT name, email, role FROM users WHERE email ILIKE '%R%';
SELECT * FROM users WHERE email LIKE 'A%';

SELECT name, role FROM users WHERE role = 'admin';
SELECT id AS post_id, title , status, content FROM posts WHERE status = 'pending';

SELECT name, role, profile_pic FROM users WHERE profile_pic IS NULL;
SELECT id, title, publication_date FROM posts WHERE publication_date IS NOT NULL;


SELECT id, name, email, role, dob FROM users WHERE role = 'admin' AND dob > '2000-01-01';
SELECT id, author_id AS author, title FROM posts WHERE 	author_id = 2 OR author_id = 4;


SELECT * FROM users LIMIT 2 OFFSET 4;
SELECT * FROM posts ORDER BY id DESC LIMIT 5;





