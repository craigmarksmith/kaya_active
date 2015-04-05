class AddBlogAuthor < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.text :description
      t.string :cloudinary_ref
      t.timestamps
    end

    add_column :blog_posts, :author_id, :integer
  end
end
