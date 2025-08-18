SELECT author_id, COUNT(*) AS total_posts FROM posts GROUP BY author_id;

SELECT role, COUNT(*) AS total_users FROM users GROUP BY role;

-- FIND USERS WITH 2 POST AND ABOVE, USER ID AND NAME
SELECT users.name, users.id, COUNT (posts.id) AS post_count 
FROM users, posts  
GROUP BY users.id, users.name;

SELECT * FROM users, posts;