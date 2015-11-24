class PurchasesController < ApplicationController

  include ActionView::Helpers::NumberHelper

  def price
    voucher = Voucher.find_by_code(params[:voucher_code])
    delivery_price = calculate_delivery(params[:country])
    new_total = (params[:total_price].to_i+delivery_price)
    new_total -= voucher.fixed_discount_amount_in_cent if voucher
    result = {
      delivery_price_in_dollars: delivery_price > 0 ? number_to_currency(delivery_price/100.00) : 'FREE',
      voucher_price_in_dollars: voucher ? number_to_currency(voucher.discount_in_dollars) : '$0.00',
      valid_voucher: !voucher.nil?,
      total_price_in_dollars: number_to_currency(new_total/100.00)
    }

    render json: result
  end

  def calculate_delivery(country_code)
    delivery_prices = {
      'AU' => 0,
      'US' => 2110,
      'CA' => 2110,
      'NZ' => 1755
    }
    default_price = 2520
    delivery_prices[country_code] || default_price
  end

  def new
    @basket = Basket.new(session)
    line_items = @basket.line_items.map{|bli| bli.to_line_item }
    @purchase = Purchase.new(line_items: line_items, country:'AU')
  end

  def complete
    @purchase = Purchase.find(session[:purchase_id])
  end

  def create
    voucher = Voucher.find_by_code(params[:purchase][:voucher_code])
    basket = Basket.new(session)

    @purchase = Purchase.new(purchase_params)

    line_items = basket.line_items.map{|bli| bli.to_line_item }
    @purchase.line_items = line_items

    @purchase.delivery_price = calculate_delivery(purchase_params[:country])
    @purchase.voucher_code = voucher.code if voucher
    @purchase.voucher_discount_amount = voucher.fixed_discount_amount_in_cent if voucher

    unless @purchase.valid?
      render :new
      return
    end

    begin
      @purchase.save!
    rescue Stripe::CardError => e
      render :new
      return
    end

    session[:purchase_id] = @purchase.id
    PurchaseMailer.confirmation(@purchase).deliver
    redirect_to action: :complete
  end

  def purchase_params
    params.require(:purchase).permit(
      :name,
      :email_address,
      :name_on_card,
      :stripe_token,
      :email_address,
      :address_line_1,
      :address_line_2,
      :city,
      :state,
      :post_code,
      :country,
      :voucher_code
    )
  end

end
