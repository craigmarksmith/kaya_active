class ChangeSortOrderToPositionOnProduct < ActiveRecord::Migration
  def change
    rename_column :products, :sort_order, :position
  end
end
