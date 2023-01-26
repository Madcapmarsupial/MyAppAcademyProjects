class Comment < ApplicationRecord
  validates :user_id, :artwork_id, presence: true

  belongs_to :author,
  class_name: 'User',
  primary_key: :id ,
  foreign_key: :user_id


  belongs_to :artwork,
  dependent: :destroy


end