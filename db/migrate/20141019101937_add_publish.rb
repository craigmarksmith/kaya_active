class AddPublish < ActiveRecord::Migration
  def change
    add_column :products, :publish, :boolean, default: false
    Product.all.each do |p|
      p.update_attribute(:publish, true)
    end
  end
end
