class AddBlogPost < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :slug
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
