class LandingController < ApplicationController
  def index
    @leggings_product = Product.find_by_slug('leo-lover-full-length')
    @body_suit_product = Product.find_by_slug('caleidoscope-body-suit-1')
    @belt_product = Product.find_by_slug('active-black-belt-belt')
  end
end