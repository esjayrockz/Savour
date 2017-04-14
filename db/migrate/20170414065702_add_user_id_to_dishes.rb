class AddUserIdToDishes < ActiveRecord::Migration[5.0]
  def change
    add_column :dishes, :user_id, :integer
    add_index :dishes, :user_id
  end
end
