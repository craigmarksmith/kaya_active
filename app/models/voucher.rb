class Voucher < ActiveRecord::Base
  validates :code, uniqueness: true

  def discount_in_dollars
    fixed_discount_amount_in_cent/100.00
  end
end