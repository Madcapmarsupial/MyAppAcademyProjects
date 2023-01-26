class AddUniqueConstriants < ActiveRecord::Migration[7.0]
  def change
    remove_index :art_listings, :artwork_id
    remove_index :art_listings, :collection_id
    add_index :art_listings, [:artwork_id, :collection_id], unique: true
  end
end
