require_relative 'questions_database'
require_relative 'question'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'reply'
require_relative 'model_base'


class User < ModelBase
  attr_accessor :id, :fname, :lname

  # def self.all
  #   data = QuestionsDatabase.instance.execute("SELECT * FROM users")
  #   data.map { |datum| User.new(datum)}
  # end

  # def self.find_by_id(id)
  #   data = QuestionsDatabase.instance.execute(<<-SQL, id)
  #     SELECT *
  #     FROM users
  #     WHERE id = ?
  #   SQL

  #   User.new(*data)
  # end

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT *
      FROM users
      WHERE fname = ?
        AND lname = ?
    SQL

    User.new(*data)
  end

  def initialize(options)

    @id = options['id']    
    @fname = options['fname']
    @lname = options['lname']
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(self.id)
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(self.id)
  end

  def average_karma
    #first
      #num of questions by (user_id) --> self.authored questions
        #likes on these questions   -->  spec_Q.num_likes

    data = QuestionsDatabase.instance.execute(<<-SQL, self.id)
      SELECT
      SUM(CASE question_likes.id
            WHEN NULL THEN 0
		          ELSE 1
		      END) / CAST(COUNT(DISTINCT(questions.id)) AS FLOAT) AS like_avg 
      FROM
        questions
      JOIN 
        question_likes ON questions.id =  question_likes.question_id
      WHERE questions.user_id = ?
    SQL
    data.first["like_avg"]
  end

end