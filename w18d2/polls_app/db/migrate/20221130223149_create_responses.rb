class CreateResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :responses do |t|
      t.timestamps
    end
      add_reference :questions, :answer_choice, foreign_key: true
      add_reference :questions, :user, foreign_key: true
  end
end
