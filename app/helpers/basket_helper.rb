module BasketHelper
  def delivery_options_for_select
    options_array = Purchase::DeliveryPrices.map do |country_code, price|
      [
        "Ship to #{ISO3166::Country[country_code]}: #{price_string(price)}",
        country_code
      ]
    end
    options_array.unshift(['Please select your delivery country', ''])
    options_array.push(["Other: #{price_string Purchase::DefaultDeliveryPrice}", 'other'])
    options_for_select(options_array)
  end

  def price_string(price)
    price > 0 ? "#{number_to_currency(price/100.00)} AUD" : "FREE"
  end
end