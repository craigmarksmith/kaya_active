class ChangeBodySuitName < ActiveRecord::Migration
  def change
    Product.where(category: 'body-suits').each do |product|
      product.update_attribute(:category, 'bodysuits')
      product.update_attribute(:name, product.name.gsub(/Body Suit/, 'Bodysuit'))
    end
  end
end
