module ProductHelper
  def menu_list_item(category_id, category_name)
    if (params[:category].nil? and category_id.nil?) or params[:category] == category_id and !homepage?
      options = {class: 'active disabled', role: 'presentation'}
    end
    content_tag :li, menu_link(category_id, category_name), options || {role: 'presentation'}
  end

  def menu_link(category_id, category_name)
    path = category_id ? category_products_path(category:category_id) : products_path
    link_to category_name, path
  end
end