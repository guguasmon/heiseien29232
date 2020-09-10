class AddRemarkToDrinks < ActiveRecord::Migration[6.0]
  def change
    add_column :drinks, :remark, :string
  end
end
