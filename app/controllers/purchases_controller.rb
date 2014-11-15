class PurchasesController < ApplicationController

  def new
    @product = Product.find_by_slug(params[:product])
    line_item = LineItem.new(price: @product.price, product_id: @product.id)
    @purchase = Purchase.new(line_items: [line_item])
  end

  def create

    begin
      @product = Product.find(params[:product_id])
      @purchase = Purchase.create!(purchase_params)
      @purchase.line_items.create(price: product.price, product_id: product.id)
      @purchase.pay!

      #confirmation email
    rescue ActiveRecord::RecordInvalid => e
      @purchase = e.record
      @purchase.line_items = [LineItem.new(price: @product.price, product_id: @product.id)]
      render :new
      return
    end

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
