class ProductsController < ApplicationController

  def index
    @products = Product.all
    @products.where!(category:params[:category]) if params[:category]
    @products.limit!(10) if Rails.env=='development'
    @products.order!(:sort_order)
  end

  def show
    @product = Product.find_by_slug!(params[:slug])
  end

end