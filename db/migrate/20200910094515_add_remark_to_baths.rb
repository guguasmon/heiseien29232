class AddRemarkToBaths < ActiveRecord::Migration[6.0]
  def change
    add_column :baths, :remark, :string
  end
end
