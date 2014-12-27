class LandingController < ApplicationController
  before_action do
    expires_in 5.minutes, public: true unless Rails.env.development? || Rails.env.test?
  end
end