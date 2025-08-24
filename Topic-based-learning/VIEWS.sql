DROP VIEW IF EXISTS active_users;
CREATE VIEW active_users AS (
	SELECT id, name FROM users WHERE role = 'user'
);

SELECT * FROM active_users;


DROP VIEW IF EXISTS active_admin;
CREATE VIEW active_admin AS (
	SELECT id, name FROM users WHERE role = 'admin'
);

SELECT * FROM active_admin;


CREATE VIEW post_author AS (
	SELECT 
		p.id AS post_id, p.title, u.name AS author, p.content
	FROM posts p
	INNER JOIN users u ON p.author_id = u.id
)

SELECT * FROM post_author WHERE author ILIKE '%ashik%';

DROP MATERIALIZED VIEW IF EXISTS author_post_count;
CREATE MATERIALIZED VIEW author_post_count AS (
	SELECT 
		u.name AS author, COUNT(p.id) AS post_count
	FROM users u
	LEFT JOIN posts p ON u.id = p.author_id
	GROUP BY (u.id, u.name)
);

SELECT * FROM author_post_count ORDER BY post_count DESC;
SELECT * FROM author_post_count ORDER BY post_count DESC;
SELECT * FROM author_post_count WHERE author ILIKE '%SH%' ORDER BY post_count DESC ;

INSERT INTO users (name, email, password)
VALUES ('ali', 'ali@examle.com', 'strignpassword'),
 ('rayan', 'rayan@examle.com', 'strignpassword');

REFRESH MATERIALIZED VIEW author_post_count;


-- HIGHEST VIEWS POSTS WITH AUTHR NAME AND PUBLISHED DATE;
CREATE MATERIALIZED VIEW popular_posts AS (
	SELECT 
		p.id AS post_id,
		p.title AS title,
		u.name AS author,
		pv.count AS views,
		p.publication_date AS published
	FROM posts p
	INNER JOIN post_views pv ON p.id = pv.post_id
	INNER JOIN users u ON p.author_id = u.id
	ORDER BY pv.count DESC
	LIMIT 5
)

EXPLAIN ANALYZE SELECT * FROM popular_posts;






