class AnswerChoice < ApplicationRecord
  validates :text, presence: true
  validates :text, uniqueness: {
    scope: :question,
    message: 'no question should have two of the same answer'
  }


  belongs_to :question,
  dependent: :destroy

  has_many :responses,
  dependent: :destroy

  
end