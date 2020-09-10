class CreateGuests < ActiveRecord::Migration[6.0]
  def change
    create_table :guests do |t|
      t.string  :first_name,         null: false
      t.string  :last_name,          null: false
      t.string  :first_name_kana,    null: false
      t.string  :last_name_kana,     null: false
      t.integer :gender_id,          null: false
      t.integer :visit1_id,          null: false
      t.integer :visit2_id ,         null: false
      t.text    :description
      t.references :user,            null: false, foreign_key: true
      t.timestamps
    end
  end
end
