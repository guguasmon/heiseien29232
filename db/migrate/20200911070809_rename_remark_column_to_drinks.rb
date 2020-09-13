class RenameRemarkColumnToDrinks < ActiveRecord::Migration[6.0]
  def change
    rename_column :drinks, :remark, :remark_drink
  end
end
