require_relative 'questions_database'
require_relative 'question'
require_relative 'question_like'
require_relative 'user'
require_relative 'reply'
require_relative 'model_base'

class QuestionFollow
  attr_accessor :id, :user_id, :question_id

  def self.all
    data = QuestionDBConnection.instance.execute("SELECT * FROM question_follows")
    data.map { |datum| QuestionFollow.new(datum)}
  end

  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_follows
      WHERE id = ?
    SQL

    QuestionFollow.new(*data)
  end

  def self.followers_for_question_id(question_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM 
        users
      JOIN 
        question_follows ON question_follows.user_id = users.id
      JOIN 
        questions ON question_follows.question_id = questions.id
      WHERE
        question_id = ?
    SQL

    data.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN 
        question_follows ON questions.id = question_follows.question_id
      WHERE
        question_follows.user_id = ? 
    SQL

    data.map { |datum| Question.new(datum)}
  end

  def self.most_followed_questions(n)
    data = QuestionDBConnection.instance.execute(<<-SQL, n)
      SELECT 
        questions.*
      FROM
        question_follows
      FULL OUTER JOIN 
        questions ON question_follows.question_id = questions.id
      GROUP BY questions.title
      ORDER BY COUNT(questions.id) DESC
      LIMIT ?    
    SQL

    data.map {|datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end
