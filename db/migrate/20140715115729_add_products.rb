class AddProducts < ActiveRecord::Migration
  def change
  	create_table :products do |t|
  		t.string :name
      t.string :length
  		t.timestamps
  	end
  end

  create_table :images do |t|
    t.belongs_to :product
    t.string :cloudinary_ref
    t.timestamps
  end
end
