require 'erb'
module BlogHelper
  def markdown_format(text)
    Kramdown::Document.new(text).to_html
  end

  def erb_compile(text)
    ERB.new(text).result(binding)
  end

  def blog_image(filename)
    image_tag("blog/#{filename}", class: "img-responsive center-block")
  end

  def related_products(product_slugs)
    render partial: 'shared/product_list', locals: {products: Product.where("slug IN (?)", product_slugs)}
  end
end