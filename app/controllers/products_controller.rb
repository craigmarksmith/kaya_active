class ProductsController < ApplicationController

  def index
    @products = Product.all
    @products.where!(category:params[:category]) if params[:category]
    @products.order!(:created_at)
  end

  def show
    @product = Product.find_by_slug(params[:slug])
  end

end