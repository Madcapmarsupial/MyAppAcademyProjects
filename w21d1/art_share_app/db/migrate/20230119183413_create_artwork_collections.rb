class CreateArtworkCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :artwork_collections do |t|
      t.references :collector, foreign_key: {to_table: :users}
      t.string :name
      t.timestamps
    end
  end
end
