class CreateDishes < ActiveRecord::Migration[5.0]
  def change
    create_table :dishes do |t|
      t.string :dish
      t.string :restaurant
      t.float :rating
      t.string :city
      t.string :cuisine
      t.string :category

      t.timestamps
    end
  end
end
