class Response < ApplicationRecord
  validate :is_author?
  validate :not_duplicate_response

  belongs_to :respondent,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  belongs_to :answer_choice,
  primary_key: :id,
  foreign_key: :answer_choice_id,
  dependent: :destroy


  has_one :question,
  dependent: :destroy,
  through: :answer_choice,
  source: :question

  def sibling_responses
    question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end

  def get_author_id
    question.poll.user_id
  end


  def does_not_respond_to_own_pull
     #join across -
     # answer choice -> question -> poll to get the poll that the response is for 
  
     #Then check the poll's author_id.

     #we should select the answer_choice the response is for
     #this will give us the one questions record we need
     #Next, we could join back to answer_choices again and onward to responses

    join_query = "
      JOIN (
      SELECT
        * 
      FROM
        answer_choices
      JOIN 
        questions ON answer_choices.question_id = questions.id
      WHERE 
        answer_choices.id = #{self.answer_choice_id}
      ) AS choice ON questions_polls.id = choice.question_id
    "

    Poll.joins(:questions)
        .joins(join_query)
        .first
        .user_id == self.user_id
  end

  def sibling_responses_two
       join_query = "
        SELECT
          responses.*
        FROM
          responses
        JOIN 
          answer_choices ON answer_choices.id = responses.answer_choice_id 
          JOIN (
            SELECT
              answer_choices.*
            FROM
              answer_choices
            JOIN 
              questions ON answer_choices.question_id = questions.id
            WHERE
              answer_choices.id = #{self.answer_choice_id}
          ) AS parent_question ON parent_question.id = responses.answer_choice_id
        "
  
      data = ActiveRecord::Base.connection.execute(join_query)
      set = data.map {|datum| datum}
      set
  end



  private
  def not_duplicate_response
    if respondent_already_answered?
      self.errors[:user_id] => 'user has already responded to this Question'
    end
  end

  def is_author?
    if self.user_id == get_author_id
      self.errors[:user_id] => 'user is the author of this poll'
    end
  end




  

  # respondent
  #   .answer_choice
  #   .question
  #   .poll
  #   .author
  #   .id == respondent.id

end