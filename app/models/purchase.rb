class Purchase < ActiveRecord::Base

  has_many :line_items

  validates_presence_of \
    :name,
    :email_address,
    :address_line_1,
    :city,
    :state,
    :post_code,
    :country

  def pay!
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account
    Stripe.api_key = ENV['SECRET_KEY']

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => total, # amount in cents, again
        :currency => "aud",
        :card => stripe_token,
        :description => description
      )
    rescue Stripe::CardError => e
      # The card has been declined
    end
  end

  def description
    "email: #{email_address}"
  end

  def total
    line_items.inject(0){|sum, ps| sum += ps.price; sum}
  end

  def total_in_dollars
    total/100.00
  end

end