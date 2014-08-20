class ApplicationController < ActionController::Base

  # don't add this just yet, I want to keep things refreshing since we have no traffic and changes are frequent.
  # before_action do
  #   expires_in 1.hour, public: true unless Rails.env.development? || Rails.env.test?
  # end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
