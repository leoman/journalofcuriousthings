class ProductsController < ApplicationController
 
  PRODUCTS_PER_PAGE = 10

  before_action :set_page, :set_total, :set_total_pages, only: [:index]

  def initialize
    super
    @@page_title = "Products Title"
    @@navigation_page = :products_path
  end

  def index
    if params[:type]
      @products = Product.where(:status => Product.statuses[:live], :product_type => params[:type]).order(date: :desc).limit(PRODUCTS_PER_PAGE).offset(@page * PRODUCTS_PER_PAGE)
    else
      @products = Product.where(:status => Product.statuses[:live]).order(date: :desc).limit(PRODUCTS_PER_PAGE).offset(@page * PRODUCTS_PER_PAGE)
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
      @total = Product.where(:status => Product.statuses[:live]).size
    end

    def set_total_pages
      if @total <= PRODUCTS_PER_PAGE
        @paginated = false
      else
        @paginated = (@total.to_f / PRODUCTS_PER_PAGE.to_f).ceil 
      end
    end
  
end