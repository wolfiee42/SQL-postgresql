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

SELECT * FROM post_author;
