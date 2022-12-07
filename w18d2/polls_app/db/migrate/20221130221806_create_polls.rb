class CreatePolls < ActiveRecord::Migration[7.0]
  def change
    create_table :polls do |t|
      t.string :title, null: false

      t.timestamps
    end
    add_reference :polls, :user, foreign_key: true

  end
end
