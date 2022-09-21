require_relative 'questions_database'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'user'
require_relative 'reply'
require_relative 'model_base'

class Question < ModelBase
  attr_accessor :id, :title, :body, :user_id

  #def self.all 
   # data = QuestionDBConnection.instance.execute("SELECT * FROM questions")
    #data.map { |datum| Question.new(datum) }
  #end

  # def self.find_by_id(id)
  #   data = QuestionDBConnection.instance.execute(<<-SQL, id)
  #     SELECT * 
  #     FROM questions 
  #     WHERE id = ?
  #   SQL

  #   Question.new(*data)
  # end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.find_by_author_id(user_id)
    data = QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT *
      FROM questions
      WHERE user_id = ?
    SQL

    data.map { |datum| Question.new(datum) }
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    User.find_by_id(self.user_id)
  end

  def replies
     Reply.find_by_question_id(self.id)
  end

  def followers
    QuestionFollow.followers_for_question_id(self.id)
  end

  def likers
    QuestionLike.likers_for_question_id(self.id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end

  # def save
  #   raise "#{self} already in database" if self.id 
  #   QuestionDBConnection.instance.execute(<<-SQL, self.title, self.body, self.user_id)
  #     INSERT INTO
  #       questions (title, body, user_id)
  #     VALUES
  #       (?, ?, ?)
  #     SQL
  #   self.id = QuestionDBConnection.instance.last_insert_row_id
  # end

end
