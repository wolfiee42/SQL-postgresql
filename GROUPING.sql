SELECT author_id, COUNT(*) AS total_posts FROM posts GROUP BY author_id;

SELECT role, COUNT(*) AS total_users FROM users GROUP BY role;

-- get all published post with their author and category
SELECT 
	p.id AS post_id,
	p.title, 
	p.status, 
	u.name AS author, 
	c.name AS category
FROM posts p
INNER JOIN users u ON p.author_id = u.id
INNER JOIN post_categories pc ON p.id = pc.post_id
INNER JOIN categories c ON pc.category_id = c.id
WHERE p.status = 'approaved';
