class AddIpToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :ip, :string
  end
end
