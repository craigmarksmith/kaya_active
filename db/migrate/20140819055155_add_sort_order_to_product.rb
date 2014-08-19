class AddSortOrderToProduct < ActiveRecord::Migration
  def change
  	add_column :products, :sort_order, :integer
  end
end
