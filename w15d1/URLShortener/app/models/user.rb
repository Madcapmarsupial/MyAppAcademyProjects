# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  premium    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  #check email validation

  has_many(
    :submitted_urls,
    class_name: 'ShortenedUrl',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :visitor_id,
    primary_key: :id
  )

  has_many :visited_urls, 
  -> { distinct },
  through: :visits, 
  source: :visited_url

end
