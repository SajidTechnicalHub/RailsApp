class AddDiscountToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :discount, :decimal
  end
end
