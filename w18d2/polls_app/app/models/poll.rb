class Poll < ApplicationRecord
  validates :title, presence: true

  belongs_to :author,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  has_many :questions,
  dependent: :destroy

  has_many :responses,
  through: :questions,
  source: :responses

end

