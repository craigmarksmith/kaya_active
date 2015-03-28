class AddPublishToBlogPost < ActiveRecord::Migration
  def change
    add_column :blog_posts, :publish, :boolean, default: false
    BlogPost.all.each{|p| p.update_attribute(:publish, true)}
  end
end
