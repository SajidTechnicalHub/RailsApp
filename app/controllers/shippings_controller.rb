class ShippingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @shippings = Shipping.all
  end

  def new
    @shipping = Shipping.new
    
  end

  def create
    @carts = session[:cart]
    @order = Order.create(subtotal:session[:total], user_id: current_user.id, discount:0, total:session[:total], total_items:@carts.size, status: 'Unpaid')
    @carts.each do |cart| 
      product = Product.find_by(id: cart["id"])
      @order_item = @order.order_items.build(quantity: cart["quantity"], product_id: product.id, unit_price:product.price)
      # @order_item.quantity = cart["quantity"]
      # @order_item.product_id = product.id
      # @order_item.order = @order
    
      @order_item.save
    end

    if Shipping.select{|ship| ship.user_id == current_user.id}.present?
      redirect_to order_path(@order.id), notice: "Shipping details of current user already exist."       
    else
     
      @shipping = Shipping.new(shipping_params)
      @shipping.user = current_user     
      
      if @shipping.save
        redirect_to order_path(@order.id), notice: "Order was successfully submitted."       
      else
        render 'checkouts/index'
      end

    end
    session[:cart] = nil
  end
  def edit
    @shipping = Shipping.find(params[:id])
  end
  def update
    
      @shipping = Shipping.find(params[:id])
      if @shipping.update(shipping_params)
        redirect_to shippings_path, notice: "Shipping was successfully updated." 
      else
        render 'edit'
      end
   
    
  end

  private

    def shipping_params
      params.require(:shipping).permit(:fname, :lname, :email, :phone, :address, :city, :state, :zip, :user_id)
    end
end
