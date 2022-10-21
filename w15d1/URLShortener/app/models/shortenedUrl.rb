class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true  #add index  unique
  validates :user_id, presence: true 
  validates :long_url, presence: true #add index 
  #check for valid url


  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many :visitors, 
    Proc.new { distinct },
    through: :visits, 
    source: :visitor



  def self.random_code
    #refactor
    unique = false
    code = ""
    long_code = SecureRandom::urlsafe_base64.split("")
    short_code = long_code.drop(1)

    until unique
      until short_code.join("").bytesize == 16
        short_code = short_code.drop(1)
      end

      code = short_code.join("")
      unique = true if !ShortenedUrl.where(short_url: code).exists?
        
    end
    return code

  end

  def self.create_short_url!(user, url)
    code = ShortenedUrl.random_code
    short_url_obj = ShortenedUrl.new(user_id: user.id, short_url: code, long_url: url)
    short_url_obj.save
    code
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visits.select(:visitor_id).count
  end

  def num_recent_uniques
    time_limit = 10.minutes.ago.to_s
    visits.select(:visitor_id).where(["created_at > ? ", time_limit ]).distinct.count
  end

end