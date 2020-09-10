class CreateBaths < ActiveRecord::Migration[6.0]
  def change
    create_table :baths do |t|
      t.integer :bathing_id,         null: false
      t.integer :infection_id,       null: false
      t.integer :timing_id,          null: false
      t.references :guest,           null: false, foreign_key: true
      t.timestamps
    end
  end
end
