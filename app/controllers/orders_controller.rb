class OrdersController < ApplicationController
  #before_action :shipping_params, only:[:update]
  def index
  end

  def show
    @order_items = OrderItem.all
    @order = Order.find(params[:id])
    @order_item = @order.order_items.all
    @shippings = Shipping.all
  end

end
