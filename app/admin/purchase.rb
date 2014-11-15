ActiveAdmin.register Purchase do
  config.sort_order = 'created_at_asc' # assumes you are using 'position' for your acts_as_list column

  index do
    column :code
    column :created_at
    column :name
    column :email_address
    column :address_line_1
    column :city
    column :country
    column :total do |purchase|
      number_to_currency purchase.total_in_dollars
    end
    actions defaults: false do |p|
      link_to 'View', admin_purchase_path(p)
    end
  end

end