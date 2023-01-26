class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true 

  has_many :comments,
    class_name: 'Comment',
    primary_key: :id,
    foreign_key: :user_id,
    dependent: :destroy
  has_many :artworks,
    class_name: 'Artwork',
    foreign_key: :artist_id,
    primary_key: :id,
    dependent: :destroy
  has_many :shares,
    dependent: :destroy,
    class_name: 'ArtworkShare',
    primary_key: :id,
    foreign_key: :viewer_id
  has_many :shared_artworks,
    through: :shares,
    source: :artwork
  has_many :likes, :as => :likeable,
    dependent: :destroy
  has_many :collections,
    class_name: 'ArtworkCollection',
    primary_key: :id,
    foreign_key: :collector_id

   def favorite_artworks
    artworks.where(is_favorite: true)
  end

  def favorite_shared_artworks
    shared_artworks.where('artwork_shares.is_favorite = true')
  end

end