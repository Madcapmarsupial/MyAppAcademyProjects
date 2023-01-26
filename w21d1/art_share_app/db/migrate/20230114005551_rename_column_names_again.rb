class RenameColumnNamesAgain < ActiveRecord::Migration[7.0]
  def change
    rename_column(:comments, :viewer_id, :user_id)
  end
end
