class AddSlug < ActiveRecord::Migration
  def change
  	add_column :products, :slug, :string, unique: true
  	Product.all.each {|p| p.save!}
  end
end
