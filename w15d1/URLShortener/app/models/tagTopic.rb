# == Schema Information
#
# Table name: tag_topics
#
#  id           :bigint           not null, primary key
#  topic        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  short_url_id :integer          not null
#
# Indexes
#
#  index_tag_topics_on_short_url_id  (short_url_id)
#  index_tag_topics_on_topic         (topic)
#
class TagTopic < ApplicationRecord
  validates :topic, :short_url_id, presence: true
  validates :short_url_id, presence: true  #add index  unique
  validates_uniqueness_of :short_url_id, scope: [:short_url_id, :topic]
  validate :check_topic

  has_many :taggings,
    class_name: 'TagTopic',
    foreign_key: :topic,
    primary_key: :topic

  belongs_to :url,
    class_name: 'ShortenedUrl',
    foreign_key: :short_url_id,
    primary_key: :id

  has_many :urls, through: :taggings, source: :url
  has_many :visits, through: :urls, source: :visits

  def popular_links
    visits.limit(5).group(:url_id).count
  end

  private 
  def check_topic
    topics = ['News', 'Politics', 'Music', 'Sports']
    if topics.include?(self.topic) == false
      errors.add :topic, "Your topics was #{self.topic}. Valid topics are --> #{topics}"
    end
  end
end