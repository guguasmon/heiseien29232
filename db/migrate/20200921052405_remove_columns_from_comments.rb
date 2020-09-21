class RemoveColumnsFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :comment_type_id, :integer
    remove_column :comments, :before, :text
    remove_column :comments, :after, :text
  end
end
