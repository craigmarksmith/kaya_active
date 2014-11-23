ActiveAdmin.register Purchase do
  config.sort_order = 'created_at_desc' # assumes you are using 'position' for your acts_as_list column

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

  show do |ad|
    attributes_table do
      row :id
      row :code
      row :stripe_token
      row :name
      row :email_address
      row :address_line_1
      row :address_line_2
      row :city
      row :state
      row :post_code
      row :country
      row :delivery_price do |purchase|
        number_to_currency(purchase.delivery_price/100.00)
      end
      row :voucher_code
      row :voucher_discount_amount do |purchase|
        number_to_currency(purchase.voucher_discount_amount/100.00)
      end
      row :total_in_dollars do |purchase|
        number_to_currency(purchase.total_in_dollars)
      end
      row :created_at
    end
    panel "Products" do
      table_for purchase.line_items do
        column "Product ID" do |item|
          item.product.id
        end
        column "Name" do |item|
          item.product.name
        end
        column "Size" do |item|
          item.size
        end
        column "Price" do |item|
          item.price_in_dollars
        end
      end
    end
    active_admin_comments
  end

  # show do
  #   panel "Products" do
  #     table_for purchase.line_items do
  #       column "Product ID" do |item|
  #         item.product.id
  #       end
  #       column "Name" do |item|
  #         item.product.name
  #       end
  #       column "Size" do |item|
  #         item.size
  #       end
  #     end
  #   end
  # end

end