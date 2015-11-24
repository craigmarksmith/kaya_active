class LineItem < ActiveRecord::Base
  belongs_to :product

  def price_in_dollars
    (price)/100.00
  end

  def line_price_in_dollars
    (price * qty)/100.00
  end
end