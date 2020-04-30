class ProductsController < ApplicationController
 
  def index
    @products = Product.all
  end

  def submit
  end
  
end