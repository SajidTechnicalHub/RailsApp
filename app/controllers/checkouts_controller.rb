class CheckoutsController < ApplicationController
  
  def index
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
       @carts.select {|cart| 
         product = Product.find_by(id: cart["id"]) 
        @session = Stripe::Checkout::Session.create({
          payment_method_types: ['card'],
          line_items: [{
             name: product.name,
             amount: product.price.to_i,
             currency: 'usd',
             quantity: cart['quantity'].to_i,
          }],

          mode: 'payment',
          success_url: checkouts_url,
          cancel_url: root_url,
      })}
    end
    respond_to do |format|
      format.js
    end
  end
end


