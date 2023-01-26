class AddForeignKeys < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "artworks", "users", column: :artist_id, primary_key: 'id'
  end
end
