class ChangePriceToDecimalToProducts < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :price, :decimal
  end
end
