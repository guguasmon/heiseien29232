class CreateFoodForbidRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :food_forbid_relations do |t|
      t.references :food,   foreign_key: true
      t.references :forbid, foreign_key: true
      t.timestamps
    end
  end
end
