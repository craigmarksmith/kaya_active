class BasketsController < ApplicationController

  def show
    @basket = Basket.new(session)
    # @basket.add(params[:product], nil)
  end

  def create
    @basket = Basket.new(session)
    @basket.add(params[:product], nil)
    redirect_to basket_path
  end

end