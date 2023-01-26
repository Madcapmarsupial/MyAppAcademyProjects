class AddUniqueMoreConstriants < ActiveRecord::Migration[7.0]
  def change
    add_index :art_listings, :artwork_id
    add_index :art_listings, :collection_id
  end
end
