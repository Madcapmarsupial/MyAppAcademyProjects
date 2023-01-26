class ChangeUsersNameColumn < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.remove :email
      t.remove :name
      
      add_column :users, :username, :string, null: false, unique: true
    end
  end
end
