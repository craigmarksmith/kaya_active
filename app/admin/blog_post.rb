ActiveAdmin.register BlogPost do

  permit_params :title, :slug, :author_id, :banner_image_ref, :publish, blog_post_items_attributes: [ :id, :reference, :content, :content_type ]

  index do
    column :title
    column :slug
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :slug
      f.input :banner_image_ref
      f.input :author_id, label: 'Author', as: :select, collection: Author.all.map{|a| [a.name, a.id]}
      f.input :publish
    end

    f.inputs do
      f.has_many :blog_post_items, :sortable => :created_at, :heading => 'Content' do |item|
        item.input :content_type, :label => 'Type', :as => :select, :collection => ['image', 'text', 'youtube', 'product']
        item.input :reference
        item.input :content
      end
    end

    f.actions
  end

end
