class ProductsController < ApplicationController

  def index
    unless Product::Categories.map{|c| c[1]}.include? params[:category] or params[:category].nil?
      render_404
      return
    end

    @products = Product.where(publish: true)
    @products.where!(category:params[:category]) if params[:category]
    @products.limit!(10) if Rails.env=='development'
    @products.order!(:position)
  end

  def show
    @product = Product.find_by_slug!(params[:slug])
  end

end