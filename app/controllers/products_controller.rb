class ProductsController < ApplicationController
 
  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by slug: params[:slug]
    if !@product
      render "errors/not_found", status: :not_found
    end
  end

  def submit
  end
  
end