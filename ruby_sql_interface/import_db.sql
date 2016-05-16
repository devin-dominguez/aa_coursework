DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255),
  lname VARCHAR(255)
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body TEXT,
  auth_id INTEGER,
  FOREIGN KEY(auth_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS questions_follows;

CREATE TABLE questions_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  user_id INTEGER
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  parent_reply_id INTEGER,
  user_id INTEGER,
  body TEXT,
  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER,
  question_id INTEGER,
  liked BOOLEAN,
  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Devin', 'Dominguez'),
  ('Brian', 'Lambert');

INSERT INTO
  questions (title, body, auth_id)
VALUES
  ('Why am I here?', 'I think therefore I am?', 2),
  ('Commute', 'Will there be parking at Concord BART when I get there?', 1);

INSERT INTO
  questions_follows (question_id, user_id)
VALUES
  (1, 2),
  (1, 1),
  (2, 1),
  (2, 2);

INSERT INTO
  replies (question_id, parent_reply_id, user_id, body)
VALUES
  (1, NULL, 1, 'What happens when the thinking stops?!'),
  (2, NULL, 2, 'What time are planning are you planning to get to the BART?'),
  (2, 2, 1, '7:30 AM'),
  (2, 3, 2, 'Maybe?');

INSERT INTO
  question_likes (user_id, question_id, liked)
VALUES
  (1, 1, 'FALSE'),
  (2, 1, 'TRUE'),
  (2, 2, 'TRUE');
