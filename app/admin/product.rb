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

  permit_params :name, :price, :category, :sold_out, :kind, :slug, :description, :fabric_and_feel, :fit_and_size, :measurements, :care
  remove_filter :fabric_and_feel
  remove_filter :fit_and_size
  remove_filter :measurements
  remove_filter :description
  remove_filter :care

  index do
    column :name
    column :price do |product|
      number_to_currency product.price_in_dollars
    end
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
      f.input :category, as: :select, collection: [['Leggings','leggings'], ['Belts','belts'], ['Body Suit','body-suits']]
      f.input :sold_out
      f.input :kind
      f.input :slug
      f.input :description
      f.input :fabric_and_feel
      f.input :fit_and_size
      f.input :measurements
    end
    f.actions
  end

end
