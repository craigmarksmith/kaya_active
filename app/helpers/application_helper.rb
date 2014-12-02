module ApplicationHelper
  def homepage?
    current_page? action: :index, controller: :landing
  end

  def category_page?
    current_page? action: :index, controller: :products
  end

  def form_auth_field
    tag(:input, :type => "hidden", :name => request_forgery_protection_token.to_s, :value => form_authenticity_token)
  end
end
