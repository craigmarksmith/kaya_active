class Purchase < ActiveRecord::Base

  after_initialize :set_code
  before_save :pay!

  has_many :line_items
  belongs_to :voucher

  validates_presence_of \
    :name,
    :name_on_card,
    :email_address,
    :address_line_1,
    :city,
    :state,
    :post_code,
    :country

  def set_code
    return if code
    o = [('A'..'Z')].map { |i| i.to_a }.flatten
    self.code = (0...10).map { o[rand(o.length)] }.join
  end

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
      errors.add(:card, e.message)
      raise e
    end
  end

  def description
    "email: #{email_address}"
  end

  def total
    t = line_items.inject(0){|sum, line_item| sum += line_item.price; sum}+(self.delivery_price||0)
    t -= self.voucher_discount_amount||0
    t
  end

  def total_in_dollars
    total/100.00
  end

end