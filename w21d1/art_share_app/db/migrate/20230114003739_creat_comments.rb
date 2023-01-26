class CreatComments < ActiveRecord::Migration[7.0]
  def change
     create_table :comments do |t|
      t.references :user_id, foreign_key: {to_table: :users}
      t.references :artwork_id, foreign_key: {to_table: :artworks}
      t.text :body, null: false

      t.timestamps
    end
  end
end

