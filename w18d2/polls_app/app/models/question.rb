class Question < ApplicationRecord
  validates :text, presence: true
  validates :text, uniqueness: {
    scope: :poll,
    message: 'no poll should have two of the same question'
  }
  belongs_to :poll

  has_many :answer_choices,
  dependent: :destroy

  has_many :responses,
  dependent: :destroy,
  through: :answer_choices,
  source: :responses

  def results
    choice_list = answer_choices.includes(:responses)

    r_count = {}
    choice_list.each do |choice|
      r_count[choice.text] = choice.responses.length
    end
    r_count


    # answer_choices
    # .group('answer_choices.text')
    # .count()


    
  end

  def query_results
   tag = self.id

   query = <<-SQL
      SELECT 
        answer_choices.*, COUNT(responses.*) AS response_count
      FROM
        answer_choices
      LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id
      WHERE answer_choices.question_id = #{tag}
      GROUP BY answer_choices.id
      
    SQL

    records_array = ActiveRecord::Base.connection.execute(query)
    records_array.each {|datum| p datum}
  end

  def new_results
    answer_choices
      .left_joins(:responses)
      .where('answer_choices.question_id = ?', self.id)
      .group('answer_choices.id')
      .count(:responses)
  end

end