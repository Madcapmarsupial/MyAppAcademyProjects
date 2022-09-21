require_relative 'questions_database'
require_relative 'question'
require_relative 'question_follow'
require_relative 'user'
require_relative 'reply'
require_relative 'model_base'


class QuestionLike
  attr_accessor :id, :question_id, :user_id

  def self.all 
    data = QuestionDBConnection.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| QuestionLike.new(datum)}
  end

  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT *
      FROM question_likes
      WHERE id = ?
    SQL

    QuestionLike.new(*data)
  end

  def self.likers_for_question_id(question_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT 
        users.*
      FROM 
        question_likes
      JOIN 
        users ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL

    data.map { |datum| User.new(datum) } 
  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(question_likes.id) AS like_count
      FROM
        question_likes
      WHERE
        question_likes.question_id = ?
    SQL

    count = data.first
    count["like_count"]
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_likes
      JOIN
        users ON question_likes.user_id = users.id
      JOIN 
        questions ON question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL

    data.map { |datum| Question.new(datum) }
  end

  def self.most_liked_questions(n)
    data = QuestionDBConnection.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM 
        questions
      JOIN 
        question_likes ON questions.id = question_likes.question_id
      GROUP BY questions.title
      ORDER BY COUNT(questions.id) DESC 
      LIMIT ?      
    SQL

    data.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end
