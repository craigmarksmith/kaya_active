class ApplicationController < ActionController::Base

  # don't add this just yet, I want to keep things refreshing since we have no traffic and changes are frequent.
  # before_action do
  #   expires_in 1.hour, public: true unless Rails.env.development? || Rails.env.test?
  # end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def raise_not_found!
    render_404
  end

  def render_404
    render template: 'shared/404', layout: 'application', status: :not_found
  end

  def set_sidebar_assets
    @products = Product.where(publish: true)
    @products.where!(category:'leggings')
    @products.limit!(4)

    @recent_articles = BlogPost.all
    @recent_articles.where!("slug != ?", params[:blog_post_slug]) if params[:blog_post_slug]
    @recent_articles.order!('created_at DESC')
    @recent_articles.limit!(3)
  end
end
