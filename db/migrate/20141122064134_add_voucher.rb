class AddVoucher < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.string :code
      t.integer :fixed_discount_amount_in_cent
      t.timestamps
    end

    add_column :purchases, :voucher_code, :string
    add_column :purchases, :voucher_discount_amount, :integer
  end
end
