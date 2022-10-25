class RemoveUniqueConstraint < ActiveRecord::Migration[7.0]
  def change
    remove_index(:tag_topics, [:topic], unique: true )
    add_index(:tag_topics, :topic)

    

  end
end
