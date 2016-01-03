class AddPayerIdToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :paypal_payer_id, :string
  end
end
