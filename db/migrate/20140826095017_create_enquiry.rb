class CreateEnquiry < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
      t.string :name
      t.string :email_address
      t.string :mobile_number
      t.text :message
      t.integer :product_id
      t.timestamps
    end
  end
end
