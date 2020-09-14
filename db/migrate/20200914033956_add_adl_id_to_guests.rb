class AddAdlIdToGuests < ActiveRecord::Migration[6.0]
  def change
    add_column :guests, :adl_id, :integer, null: false
  end
end
