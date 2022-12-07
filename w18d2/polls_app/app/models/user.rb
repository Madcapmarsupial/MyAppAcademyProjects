class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true

  has_many :responses,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Response,
  dependent: :destroy

  has_many :authored_polls,
  dependent: :destroy,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Poll

  def completed_polls
    #polls.*, 
    query = <<-SQL
      SELECT 
        polls.*
      FROM 
        polls
      JOIN 
        questions ON polls.id = questions.poll_id
      LEFT JOIN (
        SELECT
          * 
        FROM
          responses
        JOIN 
          answer_choices ON answer_choices.id = responses.answer_choice_id
        WHERE 
          responses.user_id = #{self.id}
      ) AS player_responses ON questions.id = player_responses.question_id
      GROUP BY 
        polls.id
      HAVING
        COUNT(player_responses.*) = COUNT(questions.*)
      
    SQL

    data = ActiveRecord::Base.connection.execute(query)
    set = data.map {|datum| datum}
    set
  end

  def active_rec_completed_polls
    join_query = "
      LEFT JOIN (
      SELECT
        * 
      FROM
        responses
      JOIN 
        answer_choices ON answer_choices.id = responses.answer_choice_id
      WHERE 
        responses.user_id = #{self.id}
      ) AS player_responses ON questions.id = player_responses.question_id
      "
    
      Poll.joins(:questions)
        .joins(join_query)
        .having('COUNT(player_responses.*) = COUNT(questions.*)')
        .group('polls.id')
  end


end