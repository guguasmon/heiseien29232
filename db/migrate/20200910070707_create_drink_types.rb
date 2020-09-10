class CreateDrinkTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :drink_types do |t|
      t.string :name,               null: false
      t.timestamps
    end
  end
end
