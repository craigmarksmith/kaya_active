class AddPaypalResponseToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :paypal_response, :text
  end
end
