# == Schema Information
#
# Table name: votes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  url_id     :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_votes_on_url_id   (url_id)
#  index_votes_on_user_id  (user_id)
#
class Vote < ApplicationRecord
  #validate :vote_already_cast #check if the url_id is present in the users votes list
  validate :owned   #check if the url_id is present in a list of the users sumitted urls
  #validates :url_id, presence: true #, uniqueness: true  a url has many votes
  #validates :user_id, presence: true # a user has many votes
  validates :user_id, presence: true, uniqueness: { scope: :url_id }
  validates :url_id, presence: true, uniqueness: { scope: :user_id }


  belongs_to(
    :voter,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :url,
    class_name: 'ShortenedUrl',
    foreign_key: :url_id,
    primary_key: :id
  )
  #belongs to a url
  #vote has a submiter
  #user shoulkd have votes
  #one vote per user per url


  def self.record_vote!(user, short_url_obj)
   new_vote = Vote.new(user_id: user.id, url_id: short_url_obj.id)
   new_vote.save!
  end

  private
  def owned
    id = url.id
    if voter.submitted_url_ids.include?(id)
      errors.add :user_id, "This is your URL. You may not vote on urls you have submitted"
    end
  end

end
