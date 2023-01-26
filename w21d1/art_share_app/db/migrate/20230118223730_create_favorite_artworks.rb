class CreateFavoriteArtworks < ActiveRecord::Migration[7.0]
  def change
    add_column :artworks, :is_favorited, :boolean
    add_column :artwork_shares, :is_favorited, :boolean

      
  end
end
