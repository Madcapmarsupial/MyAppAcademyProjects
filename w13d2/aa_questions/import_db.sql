PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL, 
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT,
  body TEXT,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  user_id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT,
  user TEXT NOT NULL,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);



INSERT INTO 
  users (fname, lname)
VALUES
  ('Seamus', 'O''leary'),
  ('Bob', 'Hoskins');

INSERT INTO 
  questions (title, body, user_id)
VALUES
  ('Why?', 'Why did you do that?', (SELECT id FROM users WHERE fname = 'Bob')),
  ('Who?', 'Who did that?', (SELECT id FROM users WHERE fname = 'Seamus'));

INSERT INTO 
  replies (body, user, question_id)
VALUES
  ('maybe I did', 'Seamus', (SELECT id FROM questions WHERE body = 'Who did that?')),
  ('cause', 'Bob', (SELECT id FROM questions WHERE body = 'Why did you do that?'));

INSERT INTO 
  question_likes (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Bob'), (SELECT id FROM questions WHERE body = 'Who did that?')),
  ((SELECT id FROM users WHERE fname = 'Seamus'), (SELECT id FROM questions WHERE body = 'Why did you do that?'));
