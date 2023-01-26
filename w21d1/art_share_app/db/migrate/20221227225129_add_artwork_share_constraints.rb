class AddArtworkShareConstraints < ActiveRecord::Migration[7.0]
  add_index :artwork_shares, [:viewer_id, :artwork_id], unique: true
end
