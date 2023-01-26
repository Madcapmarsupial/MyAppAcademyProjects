class RemoveUniqueConstraintOnArtistId < ActiveRecord::Migration[7.0]
  def change
    remove_index :artworks, :artist_id
  end
end
