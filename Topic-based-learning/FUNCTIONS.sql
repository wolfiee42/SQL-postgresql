-- function template
CREATE OR REPLACE FUNCTION function_name(parameters)
RETURN return_type AS $$
DECLARE
	-- variable declaraion

BEGIN
	--SQL Statement or logic
	RETURN some_value;

END;
$$ LANGUAGE plpgsql;
-- ends


CREATE OR REPLACE FUNCTION get_post_count(user_id INT)
RETURNS INT AS $$
DECLARE
	total_posts INT;
BEGIN
	SELECT COUNT(*) INTO total_posts
	FROM posts p
	WHERE p.author_id = user_id;
	
	RETURN total_posts;
END;
$$ LANGUAGE plpgsql;

SELECT get_post_count(9);


SELECT id, name, get_post_count(id) AS post_count FROM users;


 -- log post view
CREATE OR REPLACE FUNCTION post_log_view(p_post_id INT, p_user_id INT)
RETURNS INT AS $$
BEGIN
	-- insert a row in post_view_log table
	INSERT INTO post_view_log(post_id, user_id)
	VALUES (p_post_id, p_user_id)
	ON CONFLICT DO NOTHING;
	
	--update count
	UPDATE post_views
	SET count = count + 1
	WHERE post_id = p_post_id;

	RETURN 0;
END;
$$ LANGUAGE plpgsql;


SELECT post_log_view(1, 10);

SELECT * FROM post_views;




