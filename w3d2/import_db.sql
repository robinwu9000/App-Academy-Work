DROP TABLE IF EXISTS users;
CREATE TABLE users (
   id INTEGER PRIMARY KEY AUTOINCREMENT
  ,first_name TEXT NOT NULL
  ,last_name TEXT NOT NULL
);

CREATE UNIQUE INDEX users_uniq_firstname_lastname
ON users(first_name, last_name);

DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
   id INTEGER PRIMARY KEY AUTOINCREMENT
  ,title TEXT NOT NULL
  ,body TEXT NOT NULL
  ,user_id INTEGER NOT NULL

  ,FOREIGN KEY (user_id) REFERENCES users(id)

);

DROP TABLE IF EXISTS question_follows;
CREATE TABLE question_follows (
   id INTEGER PRIMARY KEY AUTOINCREMENT
  ,user_id INTEGER NOT NULL
  ,question_id INTEGER NOT NULL

  ,FOREIGN KEY (user_id) REFERENCES users(id)
  ,FOREIGN KEY (question_id) REFERENCES questions(id)

);

CREATE UNIQUE INDEX question_follows_uniq_user_id_question_id
ON question_follows(user_id, question_id);

DROP TABLE IF EXISTS replies;
CREATE TABLE replies (
   id INTEGER PRIMARY KEY AUTOINCREMENT
  ,question_id INTEGER NOT NULL
  ,user_id INTEGER NOT NULL
  ,parent_id INTEGER
  ,body TEXT NOT NULL

  ,FOREIGN KEY (question_id) REFERENCES questions(id)
  ,FOREIGN KEY (user_id) REFERENCES users(id)
  ,FOREIGN KEY (parent_id) REFERENCES replies(id)

);

DROP TABLE IF EXISTS question_likes;
CREATE TABLE question_likes (
   id INTEGER PRIMARY KEY AUTOINCREMENT
  ,question_id INTEGER NOT NULL
  ,user_id INTEGER NOT NULL

  ,FOREIGN KEY (question_id) REFERENCES questions(id)
  ,FOREIGN KEY (user_id) REFERENCES users(id)

);

CREATE UNIQUE INDEX question_likes_uniq_user_id_question_id
ON question_likes(user_id, question_id);

INSERT INTO users (first_name, last_name) VALUES
('Steve', 'Zelaznik'),
('Robin', 'Wu'),
('Ned', 'Ruggeri');

INSERT INTO questions (title, body, user_id) VALUES
('Is the world round?', 'I mean, like, the sun sets at night.',
(SELECT id FROM users WHERE first_name = 'Steve' and last_name = 'Zelaznik'));

INSERT INTO questions (id, title, body, user_id) VALUES
(2, 'How do I get to the bus?', 'The 456 bus line.',
(SELECT id FROM users WHERE first_name = 'Robin' and last_name = 'Wu'));

INSERT INTO question_follows (user_id, question_id) VALUES
((SELECT id FROM users WHERE first_name = 'Ned' and last_name = 'Ruggeri'),2);

INSERT INTO question_likes (user_id, question_id) VALUES (2, 1);

INSERT INTO replies (question_id, user_id, body) VALUES
(2, 1, 'Hell if I know.');

INSERT INTO replies (question_id, user_id, parent_id, body) VALUES
(2, 3, 1, 'Thanks for nothing, jerk!');
