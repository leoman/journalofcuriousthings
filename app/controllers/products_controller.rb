class ProductsController < ApplicationController
 
  def initialize
    super
    @@page_title = "Products Title"
    @@navigation_page = :products_path
  end

  def index
    @products = Product.where(:status => Product.statuses[:live]).order(date: :desc)
  end

  def show
    @product = Product.find_by slug: params[:slug], status: Product.statuses[:live]
    if !@product
      render "errors/not_found", status: :not_found
    end
  end

  def submit
  end
  
end