class AddPublishToBlogPost < ActiveRecord::Migration
  def change
    add_column :blog_posts, :publish, :boolean, default: false
  end
end
