class PurchasesController < ApplicationController

  def new
    @product = Product.find_by_slug(params[:product])
    line_item = LineItem.new(price: @product.price, product_id: @product.id)
    @purchase = Purchase.new(line_items: [line_item])
  end

  def complete
    @purchase = Purchase.find(session[:purchase_id])
  end

  def create
    @product = Product.find(params[:product_id])
    @purchase = Purchase.new(purchase_params)
    @purchase.line_items.new(price: @product.price, product_id: @product.id, size: params[:size])

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
      :country
    )
  end

end
