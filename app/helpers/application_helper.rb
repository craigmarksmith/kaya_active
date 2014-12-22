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

  def cl_image_tag(image_id, options = {})

    if is_mobile_request?
      mobile_quality = options.delete(:mobile_quality)
      mobile_width = options.delete(:mobile_width)
      mobile_height = options.delete(:mobile_height)

      options.merge!({quality: mobile_quality}) if mobile_quality
      options.merge!({width: mobile_width}) if mobile_width
      options.merge!({height: mobile_height}) if mobile_height
    end

    super image_id, options
  end
end
