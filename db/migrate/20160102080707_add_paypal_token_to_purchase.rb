class AddPaypalTokenToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :paypal_token, :string
  end
end
