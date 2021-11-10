class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only:[:new, :edit]
 
  $average_rating = 0
 
  # GET /products or /products.json
  def index
    
    # Category Search by name onclick dropdown menu.
     if params[:category]
      #@products = Product.all.order("created_at DESC")
      @category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(:category_id => @category_id).page(params[:page])
    elsif params[:q]
      @products = Product.where("name ILIKE ?", "%#{ params[:q]}%").page(params[:page])
      if @products.blank? 
        flash[:notice] = "No Record Found." 
      end
    elsif params[:id]
      @category = Category.find(params[:id])
      @products = @category.products.page(params[:page])
      
    else
      @products = Product.page(params[:page])

    end

    authorize @products
  end

  # GET /products/1 or /products/1.json
  def show
      @ratings = Rating.all
      @rating = @product.ratings.all
    if @product.ratings.blank?
      $average_rating = 0
    else
      $average_rating = @product.ratings.average(:rating).round(1)
    end
    
  end

  # GET /products/new
  def new
    @product = Product.new
    authorize @product
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    @product.user = current_user
    authorize @product

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy

    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
      authorize @product
    end


    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :price, :desc, :user_id, :category_id, :avatar)
    end
end
