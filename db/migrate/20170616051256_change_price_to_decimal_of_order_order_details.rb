class ChangePriceToDecimalOfOrderOrderDetails < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :total, :decimal
    change_column :order_details, :product_price, :decimal
  end
end
