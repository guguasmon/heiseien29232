class AddColumnsToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :before, :text
    add_column :comments, :after, :text
  end
end
