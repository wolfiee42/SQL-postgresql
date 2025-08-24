CREATE OR REPLACE FUNCTION create_post_view()
RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO post_views(post_id, count)
	VALUES (NEW.id, 0);
	
	RETURN NEW;

END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_create_post_view
AFTER INSERT ON posts
FOR EACH ROW
EXECUTE FUNCTION create_post_view();

INSERT INTO posts(title, author_id)
VALUES ('Testing trigger', 2);

SELECT * FROM post_views;



CREATE OR REPLACE FUNCTION update_count()
RETURNS TRIGGER AS $$
BEGIN
	UPDATE post_views
	SET count = count+1
	WHERE post_id = NEW.post_id;
	
	RETURN NEW;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER update_post_count 
AFTER INSERT ON post_view_log
FOR EACH ROW
EXECUTE FUNCTION update_count();


INSERT INTO post_view_log(post_id, user_id)
VALUES (13, 4), (13, 5), (13, 3), (13, 9), (13, 1);

SELECT * FROM post_views WHERE post_id = 13;














