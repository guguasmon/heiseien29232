class CreateDrinks < ActiveRecord::Migration[6.0]
  def change
    create_table :drinks do |t|
      t.references :drink_type,      null: false, foreign_key: true
      t.boolean :warm,               default: false, null: false
      t.integer :thickness_id,       null: false
      t.references :guest,           null: false, foreign_key: true
      t.timestamps
    end
  end
end
