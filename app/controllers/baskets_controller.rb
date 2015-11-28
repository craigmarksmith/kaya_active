class BasketsController < ApplicationController

  def show
    @basket = Basket.new(session)
  end

  def create
    @basket = Basket.new(session)
    @basket.add(params[:product], params[:size])
    redirect_to basket_path
  end

  def destroy
    @basket = Basket.new(session)
    @basket.remove(params[:product_slug], params[:size])
    redirect_to basket_path
  end

end