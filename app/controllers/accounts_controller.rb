class AccountsController < ApplicationController
  def index
    @ads_products = current_user.products.all
    @categories = current_user.categories.all
    @orders = current_user.orders.all

  end
  def show
    @order = Order.find(params[:id])
    @order_items = OrderItem.all
    @order_item = @order.order_items.all
    
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to accounts_path
  end
end
