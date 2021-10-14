class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  def index
    @shippings = Shipping.all
   
  end

  def new
 
  end

  def create
    
    if params[:id]
      product = Product.find(params[:id])
      @session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
           name: product.name,
           amount: product.price.to_i,
           currency: 'usd',
           quantity: 1,
        }],
        mode: 'payment',
        success_url: checkouts_url,
        cancel_url: root_url,
      })
    else
      
      @carts = session[:cart]
       
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
    end
    
  end

  def product_items carts
    products = []
    carts.each do |cart|
      product = Product.find_by(id: cart["id"])
      products << {name: product.name, amount: product.price.to_i, currency: 'usd', quantity: cart['quantity'].to_i}
    end
    return products
  end

  private

    def shipping_params
      params.require(:shipping).permit(:fname, :lname, :email, :phone, :address, :city, :state, :zip, :user_id)
    end

end



