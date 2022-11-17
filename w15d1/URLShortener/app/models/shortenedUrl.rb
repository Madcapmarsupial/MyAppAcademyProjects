# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_shortened_urls_on_short_url  (short_url) UNIQUE
#  index_shortened_urls_on_user_id    (user_id)
#
class ShortenedUrl < ApplicationRecord
  validate :no_spamming
  validate :nonpremium_max
  validates :short_url, presence: true, uniqueness: true  
  validates :user_id, presence: true 
  validates :long_url, presence: true

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :visits,
    dependent: :destroy,
    class_name: 'Visit',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many :visitors, 
    Proc.new { distinct },
    through: :visits, 
    source: :visitor

  has_many :tags,
    dependent: :destroy,
    class_name: 'TagTopic',
    foreign_key: :short_url_id,
    primary_key: :id

  has_many :votes,
    dependent: :destroy,
    class_name: 'Vote',
    foreign_key: :url_id,
    primary_key: :id

    has_many :voters, 
    through: :votes, 
    source: :voter

  def self.create_code
    code = gets.chomp
    if code == ""
      code = ShortenedUrl.generate_code
    end
    code 
  end

  def self.generate_code
    dictionary = Rails.root + 'app/assets/dictionary.txt'
    code = dictionary.read.split("\n").sample + "-" + dictionary.read.split("\n").sample
  end

  def self.random_code
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
    if user.premium
      code = ShortenedUrl.create_code
    else
      code = ShortenedUrl.generate_code
    end
    short_url_obj = ShortenedUrl.new(user_id: user.id, short_url: code, long_url: url)
    short_url_obj.save!
    short_url_obj
  end

  def self.hot(n)
  #ShortenedUrl::hot, sorted by vote score in the last (n) minutes
  #look through votes within the last n minutes
    ShortenedUrl.joins(:votes).where('votes.created_at > ?', n.minute.ago)
    .group('shortened_urls.id')
      .order(Arel.sql('COUNT(shortened_urls.id) DESC;'))

  end

  def self.top
  #ShortenedUrl::top, sorted by total vote score
     ShortenedUrl.joins(:votes)
      .group('shortened_urls.id')
      .order(Arel.sql('COUNT(shortened_urls.id) DESC;'))
  end

  def self.prune(n)
    prune_list = ShortenedUrl.joins(:submitter).where.missing(:visits)
      .and(ShortenedUrl.where('shortened_urls.created_at < ?', n.minute.ago))
      .and(ShortenedUrl.where('users.premium = false'))
        .or(ShortenedUrl.where('visits.updated_at < ?', n.minute.ago))
        .and(ShortenedUrl.where('users.premium = false'))
    .destroy_all
    prune_list.select do |url|
       url.visits.delete_all 
       url.tags.delete_all
       url.votes.delete_all
    end
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

  private
  def no_spamming
    urls_per_minute = ShortenedUrl.where(["created_at > ?", 1.minute.ago]).count
    if urls_per_minute > 5
      errors.add :base, "You have execeeded the urls per minute limit, please wait before submitting again"
    end
  end

  def nonpremium_max
    if (submitter.submitted_urls.count > 4 && submitter.premium == false)
      errors.add :user_id, "You are not a premium member. Free users are limited to 5 url submissions"
    end
  end
end

#url.visits.detroy_all
#User.includes(:posts).where('posts.name = ?', 'example').references(:posts)



