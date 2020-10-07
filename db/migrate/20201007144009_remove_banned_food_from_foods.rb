class RemoveBannedFoodFromFoods < ActiveRecord::Migration[6.0]
  def change
    remove_column :foods, :banned_food, :string
  end
end
