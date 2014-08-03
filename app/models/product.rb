class Product < ActiveRecord::Base

  validates :slug, uniqueness: true
  validates :category, presence: true, allow_blank: false

  has_many :images

  before_validation :set_slug

  def set_slug
    self.slug = "#{name.strip}-#{kind.strip}".downcase.gsub(/\W/, '-') unless slug
  end
end