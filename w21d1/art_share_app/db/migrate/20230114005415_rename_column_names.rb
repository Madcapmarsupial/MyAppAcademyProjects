class RenameColumnNames < ActiveRecord::Migration[7.0]
  def change
    rename_column(:comments, :user_id_id, :viewer_id)
    rename_column(:comments, :artwork_id_id, :artwork_id)
  end
end
