class Purchase < ActiveRecord::Base

  after_initialize :set_code

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

  def self.new_from_paypal(token, paypal_response, ip_address)

    ship_to_data = paypal_response.params['PaymentDetails']['ShipToAddress']

    details = {
      ip: ip_address,
      paypal_token: token,
      paypal_payer_id: paypal_response.params['payer_id'],
      name: ship_to_data['Name'],
      name_on_card: "#{paypal_response.params['PayerInfo']['PayerName']['FirstName']} #{paypal_response.params['PayerInfo']['PayerName']['LastName']}",
      email_address: paypal_response.params['payer'],
      address_line_1: ship_to_data['Street1'],
      address_line_2: ship_to_data['Street2'] || '',
      city: ship_to_data['CityName'],
      state: ship_to_data['StateOrProvince'],
      post_code: ship_to_data['PostalCode'],
      country: ship_to_data['Country'],
      paypal_response: paypal_response.to_json,
      delivery_price: 0 #revist this, we want paypal to calculate this
    }

    self.new(details)
  end

  def set_code
    return if code
    o = [('A'..'Z')].map { |i| i.to_a }.flatten
    self.code = (0...10).map { o[rand(o.length)] }.join
  end

  def express_checkout_pay!
    express_purchase_options = {
      ip: ip,
      token: paypal_token,
      payer_id: paypal_payer_id,
      currency: 'AUD'
    }

    response = EXPRESS_GATEWAY.purchase(total, express_purchase_options)
    response.success?
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
    t = line_items.inject(0){|sum, line_item| sum += (line_item.price * line_item.qty.to_i); sum}+(self.delivery_price||0)
    t -= self.voucher_discount_amount||0
    t
  end

  def total_in_dollars
    total/100.00
  end

end