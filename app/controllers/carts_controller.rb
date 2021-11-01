class CartsController < ApplicationController
  #before_action :initialize_session


  def index
    @carts = session[:cart]
  end

  def update_cart
    product_id = params[:cart][:product_id].to_i
    @products = Product.find_by(id: product_id)

    product_quantity = params[:cart][:product_quantity].to_i
    @sub_total = @products.price*product_quantity
    
    if session[:cart].select{|cart| cart["id"] == product_id}.present?
      session[:cart].find{|cart| cart["id"] == product_id}["quantity"] = product_quantity
      redirect_to carts_path
       #respond_to do |format|
        #format.js { render 'index.js.erb'}
        #format.html {  redirect_to carts_path}
      
    end
     
   
  end

  def new
    
  end

  def create
    product_id = params[:cart][:product_id].to_i
    product_quantity = params[:cart][:product_quantity].to_i

    if session[:cart].select{|cart| cart["id"] == product_id}.present?
      session[:cart].find{|cart| cart["id"] == product_id}["quantity"] += product_quantity
      redirect_to carts_path
    else
      initialize_session << {:id => product_id, :quantity => product_quantity }
      redirect_to carts_path
    end
  end

  def destroy
    product_id = params[:id].to_i
    session[:cart].delete_if {|cart| cart["id"] == product_id}
    redirect_to carts_path
  end


end
