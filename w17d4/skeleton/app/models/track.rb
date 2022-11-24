class Track < ApplicationRecord
  belongs_to :album,
    class_name: 'Album',
    foreign_key: :album_id,
    primary_key: :id

    has_one :artist,
  class_name: 'Artist',
  through: :album
end

  
