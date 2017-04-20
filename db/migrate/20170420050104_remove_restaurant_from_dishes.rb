class RemoveRestaurantFromDishes < ActiveRecord::Migration[5.0]
  def change
    remove_column :dishes, :restaurant, :string
  end
end
