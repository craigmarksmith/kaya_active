class AddKind < ActiveRecord::Migration
  def change
  	add_column :products, :kind, :string
  	remove_column :products, :length
  end
end
