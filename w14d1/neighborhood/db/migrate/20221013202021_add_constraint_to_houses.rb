class AddConstraintToHouses < ActiveRecord::Migration[7.0]
  def change
    change_column :houses, :address, :string, null: false
  end
end
