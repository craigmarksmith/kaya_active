class BlogPost <  ActiveRecord::Base
  has_many :blog_post_items

  accepts_nested_attributes_for :blog_post_items
end