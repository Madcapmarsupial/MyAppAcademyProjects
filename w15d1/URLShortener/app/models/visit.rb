class Visit < ApplicationRecord
  validates :visitor_id, presence: true
  validates :url_id, presence: true 

  
  belongs_to(
  :visitor,
  class_name: 'User',
  foreign_key: :visitor_id,
  primary_key: :id
  )

  belongs_to(
  :visited_url,
  class_name: 'ShortenedUrl',
  foreign_key: :url_id,
  primary_key: :id
  )
  


  def self.record_visit!(user, short_url_obj)
   new_visit = Visit.new(visitor_id: user.id, url_id: short_url_obj.id)
   new_visit.save
  end




end