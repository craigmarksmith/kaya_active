ActiveAdmin.register Product do


  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  permit_params :name, :price, :category, :position, :sold_out, :publish, :multiple_sizes, :kind, :slug, :description, :fabric_and_feel, :fit_and_size, :measurements, :care, images_attributes: [ :id, :cloudinary_ref ]
  remove_filter :fabric_and_feel
  remove_filter :fit_and_size
  remove_filter :measurements
  remove_filter :description
  remove_filter :care

  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false # optional; drag-and-drop across pages is not supported

  sortable

  index do
    column :name
    column :image do |product|
      if product.default_image
        cl_image_tag product.default_image.cloudinary_ref,alt: "#{product.name}",height: 100,width: 100,crop: :pad,fetch_format: :auto
      else
        ''
      end
    end
    column :price do |product|
      number_to_currency product.price_in_dollars
    end
    sortable_handle_column
    # column :position
    column :slug
    column :category
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :price, label: "Price in cents"
      f.input :category, as: :select, collection: Product::Categories
      f.input :position
      f.input :publish
      f.input :sold_out
      f.input :multiple_sizes
      f.input :kind
      f.input :slug
      f.input :description
      f.input :fabric_and_feel
      f.input :fit_and_size
      f.input :measurements
    end

    f.inputs do
      f.has_many :images, :heading => 'Images' do |image|
        image.input :cloudinary_ref
        image.input :id, as: 'hidden'
      end
    end

    f.actions
  end

end
