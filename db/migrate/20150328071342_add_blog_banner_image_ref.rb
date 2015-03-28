class AddBlogBannerImageRef < ActiveRecord::Migration
  def change
    add_column :blog_posts, :banner_image_ref, :string
  end
end
