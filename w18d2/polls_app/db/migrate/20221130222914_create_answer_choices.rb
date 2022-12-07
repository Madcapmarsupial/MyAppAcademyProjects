class CreateAnswerChoices < ActiveRecord::Migration[7.0]
  def change
    create_table :answer_choices do |t|
      t.string :text

      t.timestamps
    end
    add_reference :answer_choices, :question, foreign_key: true
  end
end
