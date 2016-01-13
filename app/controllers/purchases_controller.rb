class PurchasesController < ApplicationController

  include ActionView::Helpers::NumberHelper

  def calculate_delivery(country_code)
    delivery_prices = Purchase::DeliveryPrices
    delivery_prices[country_code] || Purchase::DefaultDeliveryPrice
  end

  def new
    if params[:country].empty?
      redirect_to basket_path, flash: {error: "Please choose a delivery destination."}
      return
    end

    if params['paypal_checkout.x']
      paypal_checkout_new
    else
      site_checkout_new
    end
  end

  def site_checkout_new
    @basket = Basket.new(session)
    line_items = @basket.line_items.map{|bli| bli.to_line_item }
    @purchase = Purchase.new(line_items: line_items, country:'AU')
    @purchase.voucher_code = params[:voucher_code] if params[:voucher_code]
    @purchase.country = params[:country]
    @purchase.delivery_price = calculate_delivery(params[:country])
  end

  def paypal_checkout_new
    @basket = Basket.new(session)
    line_items = @basket.line_items.map{|bli| bli.to_line_item }
    @purchase = Purchase.new(line_items: line_items, country:'AU')
    @purchase.voucher_code = params[:voucher_code] if params[:voucher_code]
    @purchase.delivery_price = calculate_delivery(params[:country])

    items = @purchase.line_items.map do |l|
      {
        name: l.product.name,
        description: "#{l.product.name} size: #{l.size}",
        quantity: l.qty,
        amount: l.price
      }
    end
    if @purchase.voucher_code
      items << {
          name: "Voucher: #{@purchase.voucher_code}",
          description: "Discount voucher #{@purchase.voucher_code} for #{number_to_currency(@purchase.voucher_discount_in_dollars)}",
          quantity: 1,
          amount: -@purchase.voucher_discount_amount
      }
    end

    response = EXPRESS_GATEWAY.setup_purchase(@purchase.total,
      shipping: @purchase.delivery_price,
      subtotal: @purchase.line_item_total - @purchase.voucher_discount_amount,
      handling: 0,
      tax: 0,
      ip: request.remote_ip,
      return_url: express_checkout_complete_url,
      cancel_return_url: basket_url,
      currency: "AUD",
      allow_guest_checkout: true,
      items: items
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def create
    basket = Basket.new(session)
    @purchase = Purchase.new(purchase_params)
    line_items = basket.line_items.map{|bli| bli.to_line_item }
    @purchase.line_items = line_items
    @purchase.delivery_price = calculate_delivery(purchase_params[:country])
    @purchase.voucher_code = basket.voucher_code

    unless @purchase.valid?
      render :new
      return
    end

    begin
      @purchase.pay!
      @purchase.save!
    rescue Stripe::CardError => e
      render :new
      return
    end

    session[:purchase_id] = @purchase.id
    basket.clear!
    PurchaseMailer.confirmation(@purchase).deliver
    redirect_to action: :complete
  end

  def express_checkout_create
    response = EXPRESS_GATEWAY.details_for(params['token'])

    @purchase = Purchase.new_from_paypal(params['token'], response, request.remote_ip)
    @purchase.delivery_price = calculate_delivery(response.params['PaymentDetails']['ShipToAddress']['Country'])

    basket = Basket.new(session)
    line_items = basket.line_items.map{|bli| bli.to_line_item }
    @purchase.line_items = line_items
    @purchase.voucher_code = basket.voucher_code

    unless @purchase.express_checkout_pay!
      redirect_to basket_path
      return
    end

    @purchase.save!

    session[:purchase_id] = @purchase.id
    basket.clear!
    PurchaseMailer.confirmation(@purchase).deliver
    redirect_to action: :complete
  end

  def complete
    @purchase = Purchase.find(session[:purchase_id])
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
