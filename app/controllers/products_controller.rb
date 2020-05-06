class ProductsController < ApplicationController
 
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