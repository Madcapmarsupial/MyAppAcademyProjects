class AddReferencesToResponses < ActiveRecord::Migration[7.0]
  def change
      add_reference :responses, :answer_choice, foreign_key: true
      add_reference :responses, :user, foreign_key: true
      remove_reference :questions, :answer_choice, index: false
      remove_reference :questions, :user, index: false
  end
end
