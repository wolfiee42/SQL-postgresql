SELECT id, titLe, author_id 
FROM posts;

SELECT posts.id, posts.title, posts.author_id, users.id, users.name
FROM posts
INNER JOIN users ON posts.author_id = users.id;

SELECT 
	c.id AS comment_id,
	c.content,
	u.name AS commentor
FROM comments c
INNER JOIN users u ON c.user_id = u.id

-- post id, title with views
SELECT 
	pv.post_id AS post_id,
	pv.count AS views,
	p.title
FROM post_views pv
INNER JOIN posts p ON pv.post_id = p.id;



SELECT u.id, u.name, COUNT(*) AS post_count
FROM users u
LEFT JOIN posts p ON  p.author_id = u.id
GROUP BY (u.id, u.name)
ORDER BY post_count DESC;


SELECT 
	u.name AS commentor,
	p.title AS title,
	c.content
FROM comments c
INNER JOIN users u ON c.user_id = u.id
INNER JOIN posts p ON c.post_id = p.id
WHERE c.status = 'approaved'
LIMIT 5 OFFSET 5;
