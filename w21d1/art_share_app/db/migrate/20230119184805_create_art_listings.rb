class CreateArtListings < ActiveRecord::Migration[7.0]
  def change
    create_table :art_listings do |t|
      t.references :artwork, foreign_key: {to_table: :artworks}
      t.references :collection, foreign_key: {to_table: :artwork_collections}

      t.timestamps
    end
  end
end
