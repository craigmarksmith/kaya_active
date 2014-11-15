class PurchasesController < ApplicationController

  def new
    @product = Product.find_by_slug(params[:product])
    line_item = LineItem.new(price: @product.price, product_id: @product.id)
    @purchase = Purchase.new(line_items: [line_item])
  end

  def create

    @product = Product.find(params[:product_id])
    @purchase = Purchase.new(purchase_params)
    @purchase.line_items.new(price: @product.price, product_id: @product.id)

    if !@purchase.valid?
      render :new
      return
    end

    begin
      @purchase.save!
      #confirmation email
    rescue Stripe::CardError => e
      render :new
      return
    end

    redirect_to :show
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
      :country
    )
  end

end
