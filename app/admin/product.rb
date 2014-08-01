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

  permit_params :name, :kind, :slug, :description, :fabric_and_feel, :fit_and_size, :measurements, :care
  remove_filter :fabric_and_feel
  remove_filter :fit_and_size
  remove_filter :measurements
  remove_filter :description
  remove_filter :care

  index do
    column :name
    column :slug
    column :kind
    column :created_at
    column :updated_at
    actions
  end

end
