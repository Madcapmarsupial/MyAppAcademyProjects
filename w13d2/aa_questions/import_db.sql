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
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
  
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
  ('Bob', 'Hoskins'),
  ('Jim', 'Jimson'),
  ('Pete', 'Doctor'),
  ('James', 'Rickard'),
  ('Donna', 'Hart'),
  ('Martha', 'Jones');

INSERT INTO 
  questions (title, body, user_id)
VALUES
  ('Why?', 'Why did you do that?', (SELECT id FROM users WHERE fname = 'Bob')),
  ('starwars', 'Who is lukes father?', (SELECT id FROM users WHERE fname = 'Bob')),
  ('DIY', 'how to change batteries?', (SELECT id FROM users WHERE fname = 'Seamus')),
  ('cooking', 'what is yeast even?', (SELECT id FROM users WHERE fname = 'Bob')),
  ('pens', 'pencil length?', (SELECT id FROM users WHERE fname = 'Jim')),

  ('Who?', 'Who did that?', (SELECT id FROM users WHERE fname = 'Seamus'));

INSERT INTO 
  replies (body, user_id, question_id)
VALUES
  ( 'Darth Vader', (SELECT id FROM users WHERE fname = 'Donna'), (SELECT id FROM questions WHERE title = 'starwars')
  ),
  ( 'Wow grow a brain, Donna', (SELECT id FROM users WHERE fname = 'Jim'), (SELECT id FROM questions WHERE title = 'DIY')
  ),
  ('maybe I did', 1, (SELECT id FROM questions WHERE body = 'Who did that?')),

  ('maybe who did?', 4, (SELECT id FROM questions WHERE body = 'Who did that?')),

  ('Boba fett???', 4, (SELECT id FROM questions WHERE title = 'starwars')),

  ('I think you are in the wrong thread', 2, (SELECT id FROM questions WHERE title = 'DIY')),

  ('do you mean flour', 3, (SELECT id FROM questions WHERE title = 'cooking')),

  ('I dont understand the question', 1, (SELECT id FROM questions WHERE title = 'pens')),

  ('not sure bud', 1, (SELECT id FROM questions WHERE title = 'starwars')),

  ('cause', 2, (SELECT id FROM questions WHERE body = 'Why did you do that?'));

INSERT INTO 
  question_likes (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Bob'), (SELECT id FROM questions WHERE body = 'Who did that?')),
  ((SELECT id FROM users WHERE fname = 'Donna'), (SELECT id FROM questions WHERE title = 'cooking')),
  ((SELECT id FROM users WHERE fname = 'Donna'), (SELECT id FROM questions WHERE title = 'Who?')),
  ((SELECT id FROM users WHERE fname = 'Martha'), (SELECT id FROM questions WHERE title = 'DIY')),
  ((SELECT id FROM users WHERE fname = 'Pete'), (SELECT id FROM questions WHERE title = 'starwars')),
  ((SELECT id FROM users WHERE fname = 'Jim'), (SELECT id FROM questions WHERE title = 'pens')),
  ((SELECT id FROM users WHERE fname = 'Bob'), (SELECT id FROM questions WHERE title = 'DIY')),
  ((SELECT id FROM users WHERE fname = 'Seamus'), (SELECT id FROM questions WHERE title = 'starwars')),
  ((SELECT id FROM users WHERE fname = 'Donna'), (SELECT id FROM questions WHERE title = 'starwars')),
  ((SELECT id FROM users WHERE fname = 'Bob'), (SELECT id FROM questions WHERE title = 'Why?')),
  ((SELECT id FROM users WHERE fname = 'Seamus'), (SELECT id FROM questions WHERE body = 'Why did you do that?'));



INSERT INTO 
  replies (body, user_id, question_id, parent_id)
VALUES
  ('are you sure you did Seamus?', 
    2, 
    (SELECT id FROM questions WHERE body = 'Who did that?'),
    (SELECT id FROM replies WHERE body = 'maybe I did')
  );  

INSERT INTO 
  question_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Bob'), (SELECT id FROM questions WHERE body = 'Who did that?')),
  ((SELECT id FROM users WHERE fname = 'Bob'), (SELECT id FROM questions WHERE title = 'cooking')),
  ((SELECT id FROM users WHERE fname = 'Donna'), (SELECT id FROM questions WHERE title = 'Who?')),
  ((SELECT id FROM users WHERE fname = 'Martha'), (SELECT id FROM questions WHERE title = 'DIY')),
  ((SELECT id FROM users WHERE fname = 'Pete'), (SELECT id FROM questions WHERE title = 'starwars')),
  ((SELECT id FROM users WHERE fname = 'Jim'), (SELECT id FROM questions WHERE title = 'pens')),
  ((SELECT id FROM users WHERE fname = 'Bob'), (SELECT id FROM questions WHERE title = 'starwars')),
  ((SELECT id FROM users WHERE fname = 'Seamus'), (SELECT id FROM questions WHERE title = 'starwars')),
  ((SELECT id FROM users WHERE fname = 'Bob'), (SELECT id FROM questions WHERE title = 'Why?'));
--
INSERT INTO 
  replies (body, user_id, question_id, parent_id)
VALUES
  ( 'Thats uncalled for Jim', 
    (SELECT id FROM users WHERE fname = 'Bob'),
    (SELECT id FROM questions WHERE title = 'DIY'),
    (SELECT id FROM replies WHERE body = 'Wow grow a brain, Donna')
  ),
  ( 'No Anakin', 
    (SELECT id FROM users WHERE fname = 'Bob'),
    (SELECT id FROM questions WHERE title = 'starwars'),
    (SELECT id FROM replies WHERE body = 'Darth Vader')
  ),
  ( 'Who is bob?', 
    (SELECT id FROM users WHERE fname = 'Martha'),
    (SELECT id FROM questions WHERE title = 'Who?'),
    (SELECT id FROM replies WHERE body = 'I am sure bob')
  ),
  ( 'I am sure bob', 
    1, 
    (SELECT id FROM questions WHERE body = 'Who did that?'),
    (SELECT id FROM replies WHERE body = 'are you sure you did Seamus?')
  );



 /*  INSERT INTO 
    question_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Bob'), (SELECT id FROM questions WHERE title = 'Why?')),
  ((SELECT id FROM users WHERE fname = 'Donna'), (SELECT id FROM questions WHERE title = 'starwars')),
  ((SELECT id FROM users WHERE fname = 'Donna'), (SELECT id FROM questions WHERE title = 'Who?')),
  ((SELECT id FROM users WHERE fname = 'Pete'), (SELECT id FROM questions WHERE title = 'DIY')),
  ((SELECT id FROM users WHERE fname = 'Pete'), (SELECT id FROM questions WHERE title = 'starwars')),
  ((SELECT id FROM users WHERE fname = 'Jim'), (SELECT id FROM questions WHERE title = 'pens')),
  ((SELECT id FROM users WHERE fname = 'Bob'), (SELECT id FROM questions WHERE title = 'DIY')),
  ((SELECT id FROM users WHERE fname = 'Martha'), (SELECT id FROM questions WHERE title = 'starwars')),
  ((SELECT id FROM users WHERE fname = 'Martha'), (SELECT id FROM questions WHERE title = 'Why?')),
  ((SELECT id FROM users WHERE fname = 'Seamus'), (SELECT id FROM questions WHERE title = 'starwars'));
 */