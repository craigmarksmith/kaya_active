class EnquiriesController < ApplicationController
  def new
    product = Product.find_by_slug(params[:product])
    @enquiry = Enquiry.new(product_id: product.id)
  end

  def create
    @enquiry = Enquiry.new(enquiry_params)
    if @enquiry.valid?
      @enquiry.save!
      redirect_to action: :thankyou
    else
      render :new
    end
  end

private
  def enquiry_params
    params.require(:enquiry).permit(:message, :name, :email_address, :mobile_number, :product_id)
  end
end