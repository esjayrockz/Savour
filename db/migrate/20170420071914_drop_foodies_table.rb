class DropFoodiesTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :foodies
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
