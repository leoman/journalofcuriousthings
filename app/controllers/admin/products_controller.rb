class Admin::ProductsController < Admin::BaseController
  @@title = "Products"

  before_action :set_product, only: [:show, :edit, :update, :destroy, :preview]
  before_action :set_page, :set_total, :set_total_pages, only: [:index]

  def initialize
    super
    @@navigation_page = :admin_products_path
  end

  def index
    @products = Product.order(date: :desc).limit(@@posts_per_page).offset(@page * @@posts_per_page)
  end

  def preview
    @preview = true
    @page = params[:page]
    render layout: "application", template: 'products/show'
  end

  def new
    @product = Product.new
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

  def delete_image_attachment
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_back(fallback_location: request.referer)
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def set_title
      @title = @@title
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
      productParams = params.require(:product).permit(:title, :subtitle, :price_cents, :description, :date, :mainImage, :theme_list, :theme, images: [])
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
      if @total <= @@posts_per_page
        @paginated = false
      else
        @paginated = (@total.to_f / @@posts_per_page.to_f).ceil 
      end
    end
end
