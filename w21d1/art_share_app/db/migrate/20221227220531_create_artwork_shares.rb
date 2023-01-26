class CreateArtworkShares < ActiveRecord::Migration[7.0]
  def change
    create_table :artwork_shares do |t|
      t.references :viewer_id, foreign_key: {to_table: :users}
      t.references :artwork_id, foreign_key: {to_table: :artworks}

      t.timestamps
    end
  end
end
