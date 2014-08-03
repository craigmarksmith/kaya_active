class ConvertCategoryName < ActiveRecord::Migration
  def change
    Product.all.each do |p|
      p.update_attribute(:category, p.category.downcase.gsub(/ /,'-'))
    end
  end
end
