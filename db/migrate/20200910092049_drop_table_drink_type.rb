class DropTableDrinkType < ActiveRecord::Migration[6.0]
  def change
    drop_table :drink_types
  end
end
