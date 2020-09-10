class ChangeColumnToDrinks < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :drinks, :drink_types
    remove_index :drinks, :drink_type_id
    remove_reference :drinks, :drink_type
  end
end
