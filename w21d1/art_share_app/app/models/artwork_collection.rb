class ArtworkCollection < ApplicationRecord
  belongs_to :collector,
  class_name: 'User',
  primary_key: :id,
  foreign_key: :collector_id

  has_many :listings,
  class_name: 'ArtListing',
  primary_key: :id,
  foreign_key: :collection_id

  has_many :artworks,
  through: :listings,
  source: :artwork

  
end