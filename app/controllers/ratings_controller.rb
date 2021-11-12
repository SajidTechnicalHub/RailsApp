class RatingsController < ApplicationController
  before_action :set_rating, only: %i[ show edit update  ]
  before_action :set_product
  before_action :authenticate_user!
  # GET /ratings or /ratings.json
  def index
    @ratings = Rating.all
      @product_ratings = @product.ratings.all
      @c_user_rating = current_user.product_ratings.all

  end

  # GET /ratings/1 or /ratings/1.json
  def show
  end

  # GET /ratings/new
  def new
    @rating = Rating.new
  end

  # GET /ratings/1/edit
  def edit
  end

  # POST /ratings or /ratings.json
  def create
    @rating = Rating.new(rating_params)
    @rating.user_id = current_user.id
    @rating.product_id = @product.id

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @product, notice: "Rating was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ratings/1 or /ratings/1.json
  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to @product, notice: "Rating was successfully updated." }
        format.json { render :show, status: :ok, location: @rating }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1 or /ratings/1.json
  def destroy
    @rating = @product.ratings.find(params[:id])
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to @product, notice: "Rating was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end
    def set_product
      @product = Product.find(params[:product_id])
    end
    # Only allow a list of trusted parameters through.
    def rating_params
      params.require(:rating).permit(:rating, :comment, :user_id, :product_id)
    end
end
