class CreatePurchase < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :name
      t.string :email_address

      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :post_code
      t.string :country

      t.string :name_on_card
      t.integer :amount
      t.string :stripe_token
      t.string :last_4_digits

      t.timestamps
    end

    create_table :line_items do |t|
      t.belongs_to :purchase
      t.belongs_to :product
      t.integer :price

      t.timestamps
    end
  end
end
