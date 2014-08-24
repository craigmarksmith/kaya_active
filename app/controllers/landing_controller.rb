class LandingController < ApplicationController
  def index
    @leggings_product = Product.find_by_slug('leo-lover-long-leggings')
    @body_suit_product = Product.find_by_slug('funky-zebra-body-suit')
    @belt_product = Product.find_by_slug('active-running-belt-black')
  end
end