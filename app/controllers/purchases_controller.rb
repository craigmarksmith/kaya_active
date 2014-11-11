class PurchasesController < ApplicationController

  def new
    @purchase = Purchase.new
  end

  def create

    puts "Params are: #{params.inspect}"

    purchase = Purchase.new(purchase_params)
    purchase.pay! if purchase.valid?

    if purchase.valid?
      purchase.save!
      #confirmation email
      render text: "Payment received"
    else
      render text: "Credit Card Error, please try again or contact us"
    end

  end

  def purchase_params
    params.require(:purchase).permit(:name, :stripe_token)
  end

end
