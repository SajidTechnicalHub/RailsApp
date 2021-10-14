class ShippingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @shippings = Shipping.all
  end

  def new
    @shipping = Shipping.new
    @order_item = OrderItem.new
  end

  def create
    @shipping = Shipping.new(shipping_params)
    @shipping.user = current_user     
    
      if @shipping.save
        redirect_to checkouts_path        
      else
        render 'checkouts/index'
      end
    end

  private

    def shipping_params
      params.require(:shipping).permit(:fname, :lname, :email, :phone, :address, :city, :state, :zip, :user_id)
    end

    def order_items_params
      params.require(:order_item).permit(:quantity, :product_id, :order_id, :unit_price)
    end
end
