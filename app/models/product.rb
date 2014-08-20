class Product < ActiveRecord::Base

  Categories = [['Leggings','leggings'], ['Belts','belts'], ['Body Suit','body-suits']]

  validates :slug, uniqueness: true
  validates :category, presence: true, allow_blank: false

  has_many :images

  before_validation :set_slug

  def set_slug
    self.slug = "#{name.strip}-#{kind.strip}".downcase.gsub(/\W/, '-') unless slug
  end

  def price_in_dollars
  	price/100.00 if price
  end
end