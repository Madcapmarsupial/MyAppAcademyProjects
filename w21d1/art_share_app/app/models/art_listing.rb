class ArtListing < ApplicationRecord
  validates :artwork_id, uniqueness: { scope: [:collection_id, :artwork_id],
  message: "already exists in this collection" }

  belongs_to :collection,
    class_name: 'ArtworkCollection',
    primary_key: :id,
    foreign_key: :collection_id

  belongs_to :artwork
end