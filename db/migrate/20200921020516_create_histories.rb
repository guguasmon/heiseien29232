class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.integer :log_type_id,     null: false
      t.text  :log,               null: false
      t.references :guest,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
