class BlogPostsController < ApplicationController
  def index
    @posts = BlogPost.where(publish: true).order('created_at DESC')
  end

  def show
    @post = BlogPost.find_by_slug(params[:blog_post_slug])
    @products = Product.where(publish: true)
    @products.where!(category:'leggings')
    @products.limit!(4)

    @recent_articles = BlogPost.all.where!("slug != ?", params[:blog_post_slug])
    @recent_articles.order!('created_at DESC')
    @recent_articles.limit!(3)
  end
end