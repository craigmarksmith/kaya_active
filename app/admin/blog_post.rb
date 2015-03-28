ActiveAdmin.register BlogPost do

  permit_params :title, :slug, :publish, :content, blog_post_items_attributes: [ :id, :reference, :content, :content_type ]

  form do |f|
    f.inputs do
      f.input :title
      f.input :slug
      f.input :publish
      f.input :content
    end

    f.inputs do
      f.has_many :blog_post_items, :heading => 'Content' do |image|
        image.input :content_type, :label => 'Type', :as => :select, :collection => ['image', 'text', 'youtube', 'product']
        image.input :reference
        image.input :content
      end
    end

    f.actions
  end

end
