class Artwork < ApplicationRecord
  validates :artist_id, :image_url, :title, presence: true
  validates :title, uniqueness: { scope: [:artist_id, :title],
  message: "already exists for this Artist" }

  has_many :comments,
    class_name: 'Comment',
    primary_key: :id,
    foreign_key: :artwork_id,
    dependent: :destroy
  belongs_to :artist,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :artist_id
  has_many :shares,
    dependent: :destroy,
    class_name: 'ArtworkShare',
    primary_key: :id,
    foreign_key: :artwork_id
  has_many :shared_viewers,
    through: :shares,
    source: :viewer
  has_many :likes, :as => :likeable,
    dependent: :destroy
  has_many :listings,
    class_name: 'ArtListing',
    primary_key: :id,
    foreign_key: :artwork_id
  has_many :collections,
    through: :listings,
    source: :collection
end