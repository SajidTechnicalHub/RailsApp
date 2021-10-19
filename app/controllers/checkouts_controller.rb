class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  def index
    @order_items = OrderItem.all
    @order = current_user.orders.last
    @order_item = @order.order_items.all
    @order.update(status:'Paid')

  end

  def new
 
  end

  def create
      @order_items = OrderItem.all
      @order = Order.find(params[:id])
      @carts = @order.order_items.all
      #@carts = session[:cart]
       
        @session = Stripe::Checkout::Session.create({
          payment_method_types: ['card'],
          line_items: product_items(@carts),
          mode: 'payment',
          success_url: checkouts_url,
          cancel_url: root_url
        })
      end

    respond_to do |format|
      format.js

    session[:cart] = nil
  end

  def product_items carts
    products = []
    carts.each do |cart|
      products << {name: cart.product.name, amount: cart.product.price.to_i, currency: 'usd', quantity: cart.quantity.to_i}
    end
    return products
  end

  private

    def shipping_params
      params.require(:shipping).permit(:fname, :lname, :email, :phone, :address, :city, :state, :zip, :user_id)
    end

end



