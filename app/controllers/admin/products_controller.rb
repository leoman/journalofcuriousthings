class Admin::ProductsController < ApplicationController
  TITLE = "Products"
  POSTS_PER_PAGE = 10
  layout "admin"

  before_action :set_product, only: [:show, :edit, :update, :destroy, :preview]
  before_action :set_title, only: [:index, :show, :new, :edit]
  before_action :set_page, :set_total, :set_total_pages, only: [:index]

  def index
    @products = Product.order(date: :desc).limit(POSTS_PER_PAGE).offset(@page * POSTS_PER_PAGE)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_product_path(@product), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to admin_product_path(@product), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_path, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def set_title
      @title = Admin::ProductsController::TITLE
    end

    def split_product_themes
      params[:product][:theme_ids].split(',')
    end

    def status_param
      params[:product][:status].to_i
    end

    def product_type_param
      params[:product][:product_type].to_i
    end

    def product_params
      productParams = params.require(:product).permit(:title, :subtitle, :price, :description, :date, :mainImage, :theme_list, :theme, images: [])
      productParams[:theme_ids] = split_product_themes
      productParams[:status] = status_param
      productParams[:product_type] = product_type_param
      productParams
    end

    def set_page
      @page = params[:page].to_i || 0
    end

    def set_total
      @total = Product.all.size
    end

    def set_total_pages
      if @total <= POSTS_PER_PAGE
        @paginated = false
      else
        @paginated = (@total.to_f / POSTS_PER_PAGE.to_f).ceil 
      end
    end
end
