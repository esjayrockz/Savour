class RemoveRatingFromDishes < ActiveRecord::Migration[5.0]
  def change
    remove_column :dishes, :rating, :float
  end
end
