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

  def value
    @basket = Basket.new(session)
    @basket.voucher_code = params[:voucher_code] if params[:voucher_code]
    delivery = Purchase::DeliveryPrices.has_key?(params[:country]) ? Purchase::DeliveryPrices[params[:country]] : Purchase::DefaultDeliveryPrice
    delivery = 0 if params[:country] == ''
    price = @basket.total + delivery
    render json: {
      total_price_in_dollars: number_to_currency(price/100.00),
      voucher_price_in_dollars: number_to_currency(@basket.voucher_discount_in_dollars)
    }
  end

end