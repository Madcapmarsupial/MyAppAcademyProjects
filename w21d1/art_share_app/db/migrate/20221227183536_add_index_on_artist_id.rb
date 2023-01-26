class AddIndexOnArtistId < ActiveRecord::Migration[7.0]
    add_index(:artworks, :artist_id)
   
end
