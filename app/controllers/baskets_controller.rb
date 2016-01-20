class BasketsController < ApplicationController

  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::NumberHelper

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

  def count
    @basket = Basket.new(session)
    response = pluralize(@basket.count, 'Item') if @basket.count > 0
    render json: {items: response}
  end

end