class AddDiabetesToDrinks < ActiveRecord::Migration[6.0]
  def change
    add_column :drinks, :diabetes, :boolean, default: false, null: false
  end
end
