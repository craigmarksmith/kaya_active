class Product < ActiveRecord::Base

  Categories = [['Leggings','leggings'], ['Belts','belts'], ['Body Suit','body-suits']]

  acts_as_list

  validates :slug, uniqueness: true
  validates :category, presence: true, allow_blank: false

  has_many :images
  accepts_nested_attributes_for :images

  before_validation :set_slug

  def set_slug
    self.slug = "#{name.strip}-#{kind.strip}".downcase.gsub(/\W/, '-') unless slug
  end

  def price_in_dollars
  	price/100.00 if price
  end

  def default_image
    images.first
  end
end