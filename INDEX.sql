CREATE INDEX idx_user_role ON users(role);

SELECT * FROM pg_indexes WHERE tablename = 'users';

CREATE INDEX idx_post_published_At ON posts(publication_date);

SELECT * FROM posts WHERE publication_date IS NOT NULL ORDER BY publication_date DESC;

-- index for author id filtering in posts
CREATE INDEX idx_author_id ON posts(id, author_id);
-- index for post and category id in post_categories
CREATE INDEX idx_post_category ON post_categories(post_id, category_id);
DROP INDEX idx_post_category;

-- index in post title for searching
CREATE INDEX idx_post_title ON posts(title);
SELECT * FROM pg_indexes WHERE tablename = 'posts';

CREATE INDEX inx_post_title ON posts USING GIN (to_tsvector('english', title));
SELECT * FROM posts;
SELECT * FROM posts WHERE to_tsvector('english', title) @@ plainto_tsquery('sq');