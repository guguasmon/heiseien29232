class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.integer    :staple_type_id,         null: false
      t.integer    :staple_amount_id,       null: false
      t.integer    :main_dish_type_id,      null: false
      t.integer    :main_dish_amount_id,    null: false
      t.integer    :side_dish_type_id,      null: false
      t.integer    :side_dish_amount_id,    null: false
      t.string     :banned_food   
      t.boolean    :low_salt,               default: false, null: false
      t.boolean    :soup_thick,             default: false, null: false
      t.integer    :denture_id,             null: false
      t.string     :remark_food
      t.references :guest,                  null: false, foreign_key: true
      t.timestamps
    end
  end
end
