class AccountsController < ApplicationController
  def index
    @ads_products = current_user.products.all
    @categories = current_user.categories.all
  end
end
