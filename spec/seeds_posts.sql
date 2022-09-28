TRUNCATE TABLE posts RESTART IDENTITY; 
INSERT INTO posts (title, content, views, user_id) VALUES ('My Day', 'It was good!', 100, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('Another Day', 'It was okay!', 150, 2);