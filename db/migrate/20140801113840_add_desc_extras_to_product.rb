class AddDescExtrasToProduct < ActiveRecord::Migration
  def self.up
  	add_column :products, :fabric_and_feel, :text
  	add_column :products, :fit_and_size, :text
  	add_column :products, :measurements, :text
  end

  def self.down
  	remove_column :products, :fabric_and_feel
  	remove_column :products, :fit_and_size
  	remove_column :products, :measurements
  end
end
