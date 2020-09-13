class RenameRemarkColumnToBaths < ActiveRecord::Migration[6.0]
  def change
    rename_column :baths, :remark, :remark_bath
  end
end
