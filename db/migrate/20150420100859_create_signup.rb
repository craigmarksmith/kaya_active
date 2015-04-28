class CreateSignup < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.string :email_address
      t.timestamps
    end
  end
end
