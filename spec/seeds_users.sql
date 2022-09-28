TRUNCATE TABLE users RESTART IDENTITY CASCADE; 

INSERT INTO users (email, username) VALUES ('kate@gmail.com', 'kate');
INSERT INTO users (email, username) VALUES ('john@gmail.com', 'john');
