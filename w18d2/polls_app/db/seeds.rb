# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# users = User.create([
#    { username: "bob" }, 
#    { username: "moe" }, 
#    { username: "jo" }])


 u1 = User.find_by(username: 'bob').id
 u2 =  User.find_by(username: 'moe').id
 u3 = User.find_by(username: 'jo').id

# polls = Poll.create([
#   {title: "bobs poll", user_id: id_one},
#   {title: "moe poll", user_id:  id_two},
#   {title: "jo poll", user_id: id_three}])


#   one = Poll.find_by(title: "bobs poll").id
#   two = Poll.find_by(title: "moe poll").id
#   three = Poll.find_by(title: "jo poll").id

#  questions = Question.create([
#    {text: 'is star wars any good?', poll_id: one}, 
#    {text: 'is batman really a supehero?', poll_id: one},
#    {text: 'whos sandwich is that?', poll_id: one},

#    {text: 'what is jo style?', poll_id: two},
#    {text: 'whats my name?', poll_id: two}, 

#    {text: 'mo style?', poll_id: three},
#  ])



 starwars = Question.find_by(text: 'is star wars any good?').id
 batman = Question.find_by(text: 'is batman really a supehero?').id
 sandwich = Question.find_by(text: 'whos sandwich is that?').id

 style = Question.find_by(text: 'what is jo style?').id
 name = Question.find_by(text: 'whats my name?').id

 j_style = Question.find_by(text: 'what is jo style?').id




# answer_choices = AnswerChoice.all
#  .create([
#    {text: 'yes', question_id: starwars}, 
#    {text: 'no!', question_id: starwars}, 
#    {text: 'meh', question_id: starwars}, 

#    {text: 'yes', question_id: batman}, 
#    {text: 'of course', question_id: batman}, 
#    {text: 'obviously', question_id: batman},

#    {text: 'not yours', question_id: sandwich},
#    {text: 'mine', question_id: sandwich},
#    {text: 'no mine', question_id: sandwich},

#    {text: 'A', question_id: style}, 
#    {text: 'B', question_id: style}, 
#    {text: 'C', question_id: style}, 

#    {text: 'bob?', question_id: name},
#    {text: 'rob?', question_id: name},
#    {text: 'nob?', question_id: name},

#    {text: 'no style?', question_id: j_style},
#    {text: 'what is jo style?', question_id: j_style},
#    {text: 'what??', question_id: j_style}
#  ])



#91, 92, 93, 
#94, 95, 96,   #bob
#97, 98, 99,

# 100, 101, 102, #moe
#103, 104, 105, 

#106, 107, 108 #jo

responses = Response.create([
  {user_id: u2, answer_choice_id: 99}, 
  {user_id: u2, answer_choice_id: 91}, 
  {user_id: u3, answer_choice_id: 91},

  {user_id: u3, answer_choice_id: 100},
  {user_id: u1, answer_choice_id: 101}, 
  {user_id: u3, answer_choice_id: 104},

  {user_id: u1, answer_choice_id: 106}, 
  {user_id: u1, answer_choice_id: 107}, 
  {user_id: u2, answer_choice_id: 108} 
])

