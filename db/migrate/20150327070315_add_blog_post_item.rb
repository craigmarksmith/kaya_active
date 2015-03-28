class AddBlogPostItem < ActiveRecord::Migration
  def change
    create_table :blog_post_items do |t|
      t.belongs_to :blog_post
      t.string :content_type
      t.text :content
      t.string :reference
      t.timestamps
    end
  end
end
