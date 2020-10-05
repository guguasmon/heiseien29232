class CreateForbids < ActiveRecord::Migration[6.0]
  def change
    create_table :forbids do |t|
      t.string :forbid_food, null:false, uniqueness: true
      t.timestamps
    end
  end
end
