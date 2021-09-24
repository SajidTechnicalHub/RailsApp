class HomeController < ApplicationController
  def index
    
    @category = Category.find(params[:id])
    @homes = @category.products.all
  end
end
