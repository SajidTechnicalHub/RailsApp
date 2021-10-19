class AddTotalItemsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :total_items, :integer
  end
end
