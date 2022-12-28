class CreateVote < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.integer :user_id, null: false, index: true
      t.integer :url_id, null: false, index: true
      t.timestamps
    end
  end
end
