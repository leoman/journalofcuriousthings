class ProductsController < ApplicationController
 
  PRODUCTS_PER_PAGE = 5

  before_action :set_page, :set_total, :set_total_pages, only: [:index]

  def initialize
    super
    @@page_title = "Products Title"
    @@navigation_page = :products_path
  end

  def index
    query = Product.where(status: Product.statuses[:live]).order(date: :asc).limit(PRODUCTS_PER_PAGE).offset(@page * PRODUCTS_PER_PAGE)
    if params[:type]
      @products = query.where(product_type: params[:type])
    else
      @products = query
    end

  end

  def show
    @product = Product.find_by slug: params[:slug], status: Product.statuses[:live]
    if !@product
      render "errors/not_found", status: :not_found
    end
  end

  def submit
  end

  private
    def set_page
      @page = params[:page].to_i || 0
    end

    def set_total
      query = Product.where(:status => Product.statuses[:live])
      if params[:type]
        @total = query.where(product_type: params[:type]).size
      else
        @total  = query.size
      end
    end

    def set_total_pages
      if @total <= PRODUCTS_PER_PAGE
        @paginated = false
      else
        @end = (@page + 1) * PRODUCTS_PER_PAGE
        @start = (@end - PRODUCTS_PER_PAGE) + 1
        @end = @end > @total ? @total : @end
        @paginated = (@total.to_f / PRODUCTS_PER_PAGE.to_f).ceil 
      end
    end
  
end