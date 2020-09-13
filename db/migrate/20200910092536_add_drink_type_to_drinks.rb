class AddDrinkTypeToDrinks < ActiveRecord::Migration[6.0]
  def change
    add_column :drinks, :drink_type_id, :integer, null: false
  end
end
