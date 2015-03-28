class BlogPostsController < ApplicationController
  def index
    @posts = BlogPost.where(publish: true).order('created_at DESC')
  end

  def show
    @post = BlogPost.find_by_slug(params[:blog_post_slug])
  end
end