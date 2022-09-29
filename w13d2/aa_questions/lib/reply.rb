require_relative 'questions_database'
require_relative 'question'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'user'
require_relative 'model_base'

class Reply < ModelBase
  attr_accessor :id, :body, :user_id, :question_id, :parent_id

  # def self.all
  #   data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
  #   data.map { |datum| Reply.new(datum)}
  # end

  # def self.find_by_id(id)
  #   data = QuestionsDatabase.instance.execute(<<-SQL, id)
  #     SELECT *
  #     FROM replies
  #     WHERE id = ?
  #   SQL

  #   Reply.new(*data)
  # end

  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT *
      FROM replies
      WHERE user_id = ?
    SQL

    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT *
      FROM replies
      WHERE question_id = ?
    SQL

    data.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
  end

  def author
    User.find_by_id(self.user_id)
  end

  def question
    Question.find_by_id(self.question_id)
  end

  def parent_reply
    Reply.find_by_id(self.parent_id)
  end

  def child_replies
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM replies
      WHERE parent_id = ?
    SQL

    data.map { |datum| Reply.new(datum) }
  end

end