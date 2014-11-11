class Purchase < ActiveRecord::Base

  after_initialize :set_amount

  # need
  # delivery address
  # name
  # email address
  # phone number

  def pay!
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account
    Stripe.api_key = ENV['SECRET_KEY']

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => amount, # amount in cents, again
        :currency => "aud",
        :card => stripe_token,
        :description => description
      )
    rescue Stripe::CardError => e
      # The card has been declined
    end
  end

  def description
    "email: #{email}"
  end

  def set_amount
    self.amount = 8500
  end

end